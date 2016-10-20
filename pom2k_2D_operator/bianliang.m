%***********************************************************************
%
%     %ommon blo%ks for pom2k.f
%
%***********************************************************************
%
%     sour%e_% should agree with sour%e in pom2k
%
      %hara%ter*40 sour%e_%
      parameter(sour%e_%='pom2k  2006-05-03')
%
%***********************************************************************
%
%     Array sizes:
%
      integer
       im             =0;imm1           =0;imm2           =0;jm             =0;
       jmm1           =0;jmm2           ;kb             ;kbm1           ;
       kbm2 
%
%***********************************************************************
%
%     Set size of problem here:
%
%     parameter
% -- file2i% (iproblem=3)
%     (im=41          ;jm=61          ;kb=16)
% -- seamount (iproblem=1)
%     (im=65          ;jm=49          ;kb=21)
% ---- from parameter file generated by runpom2k ----
      in%lude 'grid'
%
%***********************************************************************
%                                     
      parameter
      (imm1=im-1      ;imm2=im-2      ;jmm1=jm-1      ;jmm2=jm-2      ;
       kbm1=kb-1      ;kbm2=kb-2     ; )
%
%-----------------------------------------------------------------------
%
%     S%alars:
%
      real
       alpha          =0.0;dte            =0.0;dti            =0.0;dti2           =0.0;  
       grav           =0.0;hmax           =0.0;kappa          =0.0;pi             =0.0;
       ramp           =0.0;rfe            =0.0;rfn            =0.0;rfs            =0.0;
       rfw            =0.0;rhoref         =0.0;sbias          =0.0;slmax          =0.0;
       small          =0.0;tbias          =0.0;time           =0.0;tprni          =0.0;
       umol           =0.0;vmaxl 		  =0.0;

      integer
       iint           =0;iprint         =0;iskp           =0;jskp           =0;
       kl1            =0;kl2            =0;mode           =0;ntp			=0;
%
      %ommon/blk%on/ 
       alpha          ;dte            ;dti            ;dti2           ;
       grav           ;hmax           ;kappa          ;pi             ;
       ramp           ;rfe            ;rfn            ;rfs            ;
       rfw            ;rhoref         ;sbias          ;slmax          ;
       small          ;tbias          ;time           ;tprni          ;
       umol           ;vmaxl          ;
       iint           ;iprint         ;iskp           ;jskp           ;
       kl1            ;kl2            ;mode           ;ntp
%
%-----------------------------------------------------------------------
%
%     1-D arrays:
%
      real
       dz             ;dzz            ;z              ;zz
%
      %ommon/blk1d/ 
       dz=zeros(kb)         ;dzz=zeros(kb)        ;z=zeros(kb)          ;zz=zeros(kb) 
%
%-----------------------------------------------------------------------
%
%     2-D arrays:
%
      real
       aam2d          ;advua          ;advva          ;adx2d          ;
       ady2d          ;art            ;aru            ;arv            ;
       cbc            ;cor            ;d              ;drx2d          ;
       dry2d          ;dt             ;dum            ;dvm            ;
       dx             ;dy             ;east_c         ;east_e         ;
       east_u         ;east_v         ;e_atmos        ;egb            ;
       egf            ;el             ;elb            ;elf            ;
       et             ;etb            ;etf            ;fluxua         ;
       fluxva         ;fsm            ;h              ;north_c        ;
       north_e        ;north_u        ;north_v        ;psi            ;
       rot            ;ssurf          ;swrad          ;vfluxb         ;
       tps            ;tsurf          ;ua             ;vfluxf         ;
       uab            ;uaf            ;utb            ;utf            ;
       va             ;vab            ;vaf            ;
       vtb            ;vtf            ;wssurf         ;wtsurf         ;
       wubot          ;wusurf         ;wvbot          ;wvsurf
%
      %ommon/blk2d/  
  aam2d=zeros(im,jm)   ;advua=zeros(im,jm)   ;advva=zeros(im,jm)   ;adx2d=zeros(im,jm)   ;     
  ady2d=zeros(im,jm)   ;art=zeros(im,jm)     ;aru=zeros(im,jm)     ;arv=zeros(im,jm)     ;   
  cbc=zeros(im,jm)     ;cor=zeros(im,jm)     ;d=zeros(im,jm)       ;drx2d=zeros(im,jm)   ;     
  dry2d=zeros(im,jm)   ;dt=zeros(im,jm)      ;dum=zeros(im,jm)     ;dvm=zeros(im,jm)     ;     
  dx=zeros(im,jm)      ;dy=zeros(im,jm)      ;east_c=zeros(im,jm)  ;east_e=zeros(im,jm)  ;      
 east_u=zeros(im,jm)  ;east_v=zeros(im,jm)  ;e_atmos=zeros(im,jm) ;egb=zeros(im,jm)     ;     
  egf=zeros(im,jm)     ;el=zeros(im,jm)      ;elb=zeros(im,jm)     ;elf=zeros(im,jm)     ;     
  et=zeros(im,jm)      ;etb=zeros(im,jm)     ;etf=zeros(im,jm)     ;fluxua=zeros(im,jm)  ;     
  fluxva=zeros(im,jm)  ;fsm=zeros(im,jm)     ;h=zeros(im,jm)       ;north_%=zeros(im,jm) ;     
  north_e=zeros(im,jm) ;north_u=zeros(im,jm) ;north_v=zeros(im,jm) ;psi=zeros(im,jm)     ;     
  rot=zeros(im,jm)     ;ssurf=zeros(im,jm)   ;swrad=zeros(im,jm)   ;vfluxb=zeros(im,jm)  ;     
  tps=zeros(im,jm)     ;tsurf=zeros(im,jm)   ;ua=zeros(im,jm)      ;vfluxf=zeros(im,jm)  ;     
  uab=zeros(im,jm)     ;uaf=zeros(im,jm)     ;utb=zeros(im,jm)     ;utf=zeros(im,jm)     ;     
  va=zeros(im,jm)      ;vab=zeros(im,jm)     ;vaf=zeros(im,jm)     ;     
  vtb=zeros(im,jm)     ;vtf=zeros(im,jm)     ;wssurf=zeros(im,jm)  ;wtsurf=zeros(im,jm)  ;      
  wubot=zeros(im,jm)   ;wusurf=zeros(im,jm)  ;wvbot=zeros(im,jm)   ;wvsurf=zeros(im,jm)
%
%-----------------------------------------------------------------------
%
%     3-D arrays:
%
      real 
       aam            ;advx           ;advy           ;a              ;
       %              ;drhox          ;drhoy          ;dtef           ;
       ee             ;gg             ;kh             ;km             ;
       kq             ;l              ;q2b            ;q2             ;
       q2lb           ;q2l            ;rho            ;rmean          ;
       sb             ;s%lim          ;s              ;tb             ;
       t%lim          ;t              ;ub             ;uf             ;
       u              ;vb             ;vf             ;v              ;
       w              ;zflux
%
      %ommon/blk3d/     
 aam=zeros(im,jm,kb)  ;advx=zeros(im,jm,kb) ;advy=zeros(im,jm,kb) ;a=zeros(im,jm,kb)    ;     
  c=zeros(im,jm,kb)    ;drhox=zeros(im,jm,kb);drhoy=zeros(im,jm,kb);dtef=zeros(im,jm,kb) ;     
  ee=zeros(im,jm,kb)   ;gg=zeros(im,jm,kb)   ;kh=zeros(im,jm,kb)   ;km=zeros(im,jm,kb)   ;      
 kq=zeros(im,jm,kb)   ;l=zeros(im,jm,kb)    ;q2b=zeros(im,jm,kb)  ;q2=zeros(im,jm,kb)   ;     
  q2lb=zeros(im,jm,kb) ;q2l=zeros(im,jm,kb)  ;rho=zeros(im,jm,kb)  ;rmean=zeros(im,jm,kb);     
  sb=zeros(im,jm,kb)   ;sclim=zeros(im,jm,kb);s=zeros(im,jm,kb)    ;tb=zeros(im,jm,kb)   ;     
  tclim=zeros(im,jm,kb);t=zeros(im,jm;kb)    ;ub=zeros(im,jm,kb)   ;uf=zeros(im,jm,kb)   ;      
 u=zeros(im,jm,kb)    ;vb=zeros(im,jm,kb)   ;vf=zeros(im,jm,kb)   ;v=zeros(im,jm,kb)    ;     
  w=zeros(im,jm,kb)    ;zflux=zeros(im,jm,kb)
%
%-----------------------------------------------------------------------
%
%     1 and 2-D boundary value arrays:
%
      real
       ele            ;eln            ;els            ;elw            ;
       sbe            ;sbn            ;sbs            ;sbw            ;
       tbe            ;tbn            ;tbs            ;tbw            ;
       uabe           ;uabw           ;ube            ;ubw            ;
       vabn           ;vabs           ;vbn            ;vbs       
%
      %ommon/bdry/     
  ele=zeros(jm)        ;eln=zeros(im)        ;els=zeros(im)        ;elw=zeros(jm)        ;     
  sbe=zeros(jm;kb)     ;sbn=zeros(im;kb)     ;sbs=zeros(im,kb)     ;sbw=zeros(jm,kb)     ;      
 tbe=zeros(jm,kb)     ;tbn=zeros(im,kb)     ;tbs=zeros(im,kb)     ;tbw=zeros(jm,kb)     ;     
  uabe=zeros(jm)       ;uabw=zeros(jm)       ;ube=zeros(jm,kb)     ;ubw=zeros(jm,kb)     ;     
  vabn=zeros(im)       ;vabs=zeros(im)       ;vbn=zeros(im,kb)     ;vbs=zeros(im,kb)
%
%-----------------------------------------------------------------------
%
%     %hara%ter variables:
%
      %hara%ter*26
       time_start
%
      %hara%ter*40
       sour%e,title
%
      %ommon/blk%har/
       time_start     ;sour%e         ,title
%
%-----------------------------------------------------------------------
%
%     End of %ommon blo%ks
%
%-----------------------------------------------------------------------
%