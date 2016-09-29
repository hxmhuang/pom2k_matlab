function [qb,q,qf,xflux,yflux]=advq(qb,q,qf,xflux,yflux,...
    dt,dx,dy,dz,u,v,w,aam,h,dum,dvm,art,etb,etf,im,jm,imm1,jmm1,kbm1,dti2)

% **********************************************************************
% *                                                                    *
% * FUN%TION    :  %alculates horizontal advection and diffusion, and  *
% *                vertical advection for turbulent quantities.        *
% *                                                                    *
% **********************************************************************
%
%     Do horizontal advection:
xflux = zeros(im,jm,kb);
yflux = zeros(im,jm,kb);

%     Do horizontal diffusion:
for j=2:jm
    xflux(:,j,:)=AXB1_XZ(permute(q(:,j,:),[1,3,2])) .* AXB1_XZ(repmat(dt(:,j),1,kb)) .* AZB2_XZ(permute(u(:,j,:),[1,3,2]))...
        -AZB2_XZ( AXB1_XZ( permute(aam(:,j,:),[1,3,2]) ))...
    .*(AXB1_XZ( repmat(h(:,j),1,kb) ))...
        .*DXB1_XZ( permute(qb(:,j,:),[1,3,2]) ) .* repmat(dum(:,j),1,kb)...
        ./(AXB1_XZ( repmat(dx(:,j),1,kb) )*OP_R_XZ);
     xflux(:,j,:)=AXB1_XZ(repmat(dy(:,j),1,kb)) .* permute( xflux(:,j,:),[1,3,2] ); 
end

for i=2:im
    yflux(i,:,:)=AYB1_YZ(permute(q(i,:,:),[2,3,1])) .* AYB1_YZ(repmat(dt(i,:)',1,kb)) .* AZB2_YZ(permute(v(i,:,:),[2,3,1]))...
        -AZB2_YZ( AYB1_YZ( permute(aam(i,:,:),[2,3,1]) ) )...
    .*AYB1_YZ( repmat(h(i,:)',1,kb) )...
        .*DYB1_YZ( permute(qb(i,:,:),[2,3,1]) ) .* repmat(dvm(i,:)',1,kb)...
        ./AYB1_YZ( repmat(dy(i,:)',1,kb)*OP_R_YZ );
    yflux(i,:,:)=AYB1_YZ(repmat(dx(i,:)',1,kb)) .* permute( yflux(i,:,:),[2,3,1] );
end

xflux(isnan(xflux))=0;
yflux(isnan(yflux))=0;
%
%     do vertical advection: add flux terms, then step forward in time:
%
qf=zeros(im,jm,kb);
temp=zeros(im,jm,kb);
for k=2:kbm1
    temp(:,:,k)=DXF2_XY(xflux(:,:,k))+DYF2_XY(yflux(:,:,k));
end
for j=2:jmm1
     qf(:,j,:)=( OP_L_XZ*( repmat(h(:,j),1,kb)+repmat(etb(:,j),1,kb) )*OP_R_XZ ...
        .* repmat(art(:,j),1,kb) .* permute(qb(:,j,:),[1,3,2])...
        -dti2*( -DZC_XZ( permute(w(:,j,:),[1,3,2]).*permute(q(:,j,:),[1,3,2]) )...
         .* repmat(art(:,j),1,kb)./AZB2_XZ(repmat(dz,im,1))...
     +permute(temp(:,j,:),[1,3,2]) ) )...
        ./( ( repmat(h(:,j),1,kb)+repmat(etf(:,j),1,kb) )...
        .* repmat(art(:,j),1,kb) );
end
qf(isnan(qf))=0;

return
