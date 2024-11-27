% close all;
% clc;
% clear all;

% gen_dataS_Plus_2;  % sample data generation
gen_dataS_Plus_1;  % sample data generation
dataSetSP=yd3;     % you can set your own data to dataSetSP instead of yd3

% dataSetSP=yd2b;
Ts=0.0022;

part_res={};
% cd(default_dir);
pL={};
% %     for j2=1:k % files (# of trials)
% %          for j3=1:32% session
%     for j2=1:length(source_folder) % files (# of trials)
% %     for j2=2:2
% %          for j3=1:1% session
%          for j3=rangeSWst:-1:rangeSW % skipW
%             skipW       =skipWf(j3);

            fignum=1;
            figure(fignum); clf;
            fignum=fignum+1;figure(fignum);clf;
            fignum=fignum+1;figure(fignum);clf;

            fignum=1;
            figure(fignum);

            set(1,'Position',[30   500   1000   500]);
            set(2,'Position',[1000   300   600   700]);
            set(3,'Position',[1000   170   600   700]);
%             set(4,'Position',[30   30   1000   500]);
%             set(5,'Position',[1000   100   600   700]);
%             set(6,'Position',[1000   1   600   700]);
%             categ=j2; session=1; 
%             default_dir=pwd; 
%             cd(source_folder);
            
%             strF=fdname{categ,session}; 
%             sprintf('Analyzing target file and session  are ... \r\n category: %d\r\n session: %d\r\n filename: %s\r\n ',categ,session,strF);
%             sprintf('Analyzing target file and session  are ... \r\n category: %d\r\n skipW: %d\r\n filename: %s\r\n ',categ,skipW,strF);
            
            % segmentData = load(flist_select{fnum});
%             w   =loadsig{j2,1,j3};
            j=1; r=2; r=3; %r=4;
            r=1;
%             Ts=20/1000;
            w   =dataSetSP;
            w   =interp(w,r);
            
%             subDtmp=subD{j2,1,j3};
%             f_tag=f_tagD{j2,1,j3};
            f_tag='sample';
%             xdata_tmp=xd{j2,1,j3};
            xdata_tmp=Ts*((1:length(w))-1);
            % 
            % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            % 
            qmf=MakeONFilter('Symmlet',10);
%             qmf=MakeONFilter('Daubechies',10);
            
            % qmf=[	.026670057901	.188176800078	.527201188932	...
            % 				.688459039454	.281172343661	-.249846424327	...
            % 				-.195946274377	.127369340336	.093057364604	...
            % 				-.071394147166	-.029457536822	.033212674059	...
            % 				.003606553567	-.010733175483	.001395351747	...
            % 				.001992405295	-.000685856695	-.000116466855	...
            % 				.000093588670	-.000013264203					];
            
            %%
            dict = MakeList('UDWT','DST','DIRAC');
            % pars1 = MakeList(2,32,0);
            pars1 = MakeList(0,32,0);
            pars2 = MakeList(qmf,0.5,0);
            pars3 = MakeList(5,0,0); 
            %% 
            % 
            % % Initializations. Put the signal as a column vector.
            mixedsignal	  = w(:);
            N  	          = length(mixedsignal);

%             N  	          = 100000;
%             mixedsignal	  = w(1:N);
            n      	      = 2^(nextpow2(N));
            sigpad 	      = zeros(n,1);
            sigpad(1:N)   = mixedsignal;
            maskpad	      = ones(n,1);
%             xdata         = 1:N;
            xdata         = xdata_tmp; 
%             xdata         = xdata(1:N);
        
            [n,J]	      = dyadlength(sigpad);
            thdtype       = 'Soft';
            thdtype_name = ['Threshold type: ' thdtype];
            
            % Dictionary metadata.
            numberofdicts = LengthList(dict);
            part	      = zeros(n,numberofdicts);
        
        
            itermax 	= 100;
%             itermax 	= 1500;
%             itermax 	= 2000; % 0.915
% %             itermax 	= 3000; % 0.942
            %             itermax 	= 1000;
            expdecrease	= 0;
            lambdastop	= 4;  
            lambdastop	= 3; 
            lambdastop	= 2.3; 
%             lambdastop	= 10; 
%             lambdastop	= 10; 
%             lambdastop	= 1.5; 
%             lambdastop	= 2.9; 
            fdict={'UDWT', 'DST', 'DIRAC'};
                
             % To estimate the WGN standard deviation using the MAD.
            
	            
            wc = FWT_PO(sigpad,J-1,qmf);   %%%Forward Wavelet Transform (periodized, orthogonal)
            sigma = MAD(wc(n/2+1:n/2+floor(N/2)));   % Mean absolute deviation
            
            stopcriterion = lambdastop*sigma;
            stopcriterion_value = sprintf('Stopping threshold: %f x sigma=%f',lambdastop,stopcriterion);
            
            % First pass: coeffs of the original signl in each dictionary.
	        coeff = FastLA(sigpad,dict,pars1,pars2,pars3);
            
            % % Calculate the starting thd, which is the minimum of maximal coefficients of the signal in each dictionary.
            deltamax=StartingPoint(coeff);
            delta=deltamax;
            lambdamax_value   = sprintf('Starting threshold: %f',deltamax);
            if expdecrease	
                lambda=(deltamax/stopcriterion)^(1/(1-itermax)); % Exponential decrease.
                lambdasched_value = sprintf('Exponential decrease schedule of threshold: step=%f',lambda);
            else	 	
                lambda=(deltamax-stopcriterion)/(itermax-1);	 % Slope of the linear decrease. 
                lambdasched_value = sprintf('Linear decrease schedule of threshold: step=%f',lambda);
            end
            nbpr=ceil(sqrt(numberofdicts+2));
            % 	fig1=figure(1); 
            subplot(nbpr,1,1);
            plnum=1;
            pL{plnum}=plot(xdata,mixedsignal,'b-'); hold on; axis tight; grid on;
            
            
%             dd=abs(max(mixedsignal)-min(mixedsignal))*corr(mixedsignal,subDtmp)+mean(mixedsignal);
%             dd=abs(max(mixedsignal)-min(mixedsignal))*corr(mixedsignal,subDtmp);
%             dd=(subDtmp-mean(subDtmp))./abs(max(subDtmp)-min(subDtmp));
%             dd=abs(max(mixedsignal)-min(mixedsignal))*dd+mean(mixedsignal);
%             plot(xdata,dd,'-','Color',[0.5,0.5,0.5],'LineWidth',3); hold off; 
            plnum=plnum+1;

            sTagH_a2='test';
            title(['Original Signal: ',sTagH_a2]);
            for np=1:numberofdicts
              subplot(nbpr,3,nbpr*1+np);
              pL{plnum}=plot(xdata,part(1:N,np),'k-');
              title(sprintf('MCA Part %d',np));axis tight; grid on;
              plnum=plnum+1;
            end

            subplot(nbpr,1,3);
            pL{plnum}=plot(xdata,sum(part(1:N,:),2),'r-');
            title('Reconstructed Signal');axis tight; grid on;

%             set(fignum,'Name','Signal Decomposition with MCA '); 
            set(fignum,'Name',sprintf('<1st Step> MCA Process %s',f_tag)); 
            drawnow;
        % 
            % Start the modified Block Relaxation Algorithm.
            iter=0;
%             lambda=0.1;
%             for iter=0:itermax-1
            for iter=0:itermax-1
%             while covariance<covTh && iter<itermax
        
%             for iter=0:0
            %for i=1:1
              % Calculate the residual signal.
              residual=sigpad-maskpad.*sum(part,2);
                
              % Cycle over dictionaries.
                for nb=1:numberofdicts
                    % Update Parta assuming other parts fixed.
                    % Solve for Parta the marginal penalized minimization problem (Hard thesholding, l_1 -> Soft).
                    NAME   = NthList(dict,nb);
                    PAR1   = NthList(pars1,nb);
                    PAR2   = NthList(pars2,nb);
                    PAR3   = NthList(pars3,nb);
                    Ra=part(:,nb)+residual;
                    Ca = FastLA(Ra,NAME,PAR1,PAR2,PAR3);
                    coeffa = Ca{1}; 
    
                    % Do not threshold low-frequency coefficients
                    coeffa(2).coeff = eval([thdtype 'Thresh(coeffa(2).coeff,delta)']); 
                    Ca{1} = coeffa;
                    part(:,nb)  = FastLS(Ca,NAME,PAR1,PAR2,PAR3);
                 
                end
                    
               % Update the regularization parameter delta. it should modify at each
               % iterations
               if expdecrease	
                   delta=delta*lambda; % Exponential decrease.	
               else		
                   delta=delta-lambda; % Linear decrease.
               end
               covariance=max(abs(xcov(mixedsignal,sum(part(1:N,:),2),'coeff')));

               % Displays the progress.
                          
                         
    %               subplot(nbpr,1,1);
              plnum=1; 
              set(pL{plnum},'YData',mixedsignal);
              plnum=plnum+1;
              for np=1:numberofdicts
                set(pL{plnum},'YData',part(1:N,np));
                plnum=plnum+1;
              end
	          set(pL{plnum},'YData',sum(part(1:N,:),2));
%               title('Reconstructed Signal');axis tight; 
              title(iter);
              drawnow;
%               iter=iter+1;
            end

            subplot(nbpr,1,1);hold on;
            plot(xdata,sum(part(1:N,:),2),'r-');
            size(part)
            %fignum=[figure(1) figure(2)]
            % % Crop data to original size.
	        parts = part(1:N,:);
            
%             for ik=1:size(part,2)
%                 part_res{j2,1,j3,ik}=part(1:N,ik);
%             end
            %     
            covariance=max(abs(xcov(mixedsignal,sum(parts(1:N,:),2),'coeff')));
            stP=sprintf('Reconstructed Signal by MCA (corr=%3.3f)',covariance);
	        
            subplot(nbpr,1,3);
            title(stP);

            fignum=fignum+1;
            figure(fignum); 
              
            subplot(5,1,1);
            plot(xdata,mixedsignal,'k-');
            title(['Original Signal: ',sTagH_a2]); axis tight; grid on;
            
            subplot(5,1,2);
            plot(xdata,sum(part(1:N,:),2),'k-'); 
            title(stP); axis tight; grid on;
            axL2={};
            for np=1:numberofdicts
                axL2{np}=subplot(5,1,np+2);hold on;
%                 axL2{np} = nexttile;
                plot(xdata,mixedsignal,'-','Color',[0.5,0.5,0.5]);
                plot(xdata,part(1:N,np),'r-'); 
                title(sprintf('%s',fdict{np}));axis tight; grid on;
            end
%             set(fignum,'Name','(superimposed) Signal Decomposition based on UDWT DST DIRAC Component ');
%             set(fignum,'Name','(superimposed) Signal Decomposition based on UDWT DST DIRAC Component ');
            set(fignum,'Name',sprintf('<1st Step> MCA superimposed %s',f_tag)); 
            linkaxes([axL2{1} axL2{2} axL2{3}],'x'); 

            fignum=fignum+1;
            figure(fignum); 
              
            subplot(5,1,1);
            plot(xdata,mixedsignal,'k-');
            title(['Original Signal: ',sTagH_a2]); axis tight; grid on;
            
            subplot(5,1,2);
            plot(xdata,sum(part(1:N,:),2),'k-'); 
            title(stP); axis tight; grid on;
            
            for np=1:numberofdicts
                subplot(5,1,np+2);
%                 hold on;
%                 plot(xdata,mixedsignal,'-','Color',[0.5,0.5,0.5]);
                plot(xdata,part(1:N,np),'k-'); 
                title(sprintf('%s',fdict{np}));axis tight; grid on;
            end
%             set(fignum,'Name','Signal Decomposition based on UDWT DST DIRAC Component ');
            set(fignum,'Name',sprintf('<1st Step> MCA result %s',f_tag)); 
            datafname='TM_result';
%             save_fig;
    
%             cd(datafname);
%             save([datafname,'.mat']);
%             cd(default_dir);
%          end
%     end
%      
   
w_first=part(120:N-120,2);
xd_1=xdata_tmp(120:N-120)';
Ts=Ts/r;
covRsig=covariance;
TsF=Ts;