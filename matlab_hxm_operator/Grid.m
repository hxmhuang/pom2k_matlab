classdef Grid
    properties
        dim
        type
        
        dx_f_map
        dy_f_map
        dz_f_map

        dx_b_map
        dy_b_map
        dz_b_map
        
        axf_map
        axb_map
        ayf_map
        ayb_map
        azf_map
        azb_map
        
        dxf_map
        dxb_map
        dyf_map
        dyb_map
        dzf_map
        dzb_map
        
        area_map
        mask_map
        
        
        grid_size_initialized
        grid_mask_initialized
    end
    methods
        function obj = Grid(dim_, type_)
            obj.dim = dim_;
            obj.type = type_;
            obj.grid_size_initialized = false;
            obj.grid_mask_initialized = false;
            
            obj.dx_f_map    = containers.Map('KeyType', 'int32', 'ValueType', 'any');
            obj.dy_f_map    = containers.Map('KeyType', 'int32', 'ValueType', 'any');
            obj.dz_f_map    = containers.Map('KeyType', 'int32', 'ValueType', 'any');

            obj.dx_b_map    = containers.Map('KeyType', 'int32', 'ValueType', 'any');
            obj.dy_b_map    = containers.Map('KeyType', 'int32', 'ValueType', 'any');
            obj.dz_b_map    = containers.Map('KeyType', 'int32', 'ValueType', 'any');
            
            obj.area_map    = containers.Map('KeyType', 'int32', 'ValueType', 'any');
            obj.mask_map    = containers.Map('KeyType', 'int32', 'ValueType', 'any');
            
            dxf_map = containers.Map('KeyType', 'int32', 'ValueType', 'any');
            dxb_map = containers.Map('KeyType', 'int32', 'ValueType', 'any');
            dyf_map = containers.Map('KeyType', 'int32', 'ValueType', 'any');
            dyb_map = containers.Map('KeyType', 'int32', 'ValueType', 'any');
            dzf_map = containers.Map('KeyType', 'int32', 'ValueType', 'any');        
            dzb_map = containers.Map('KeyType', 'int32', 'ValueType', 'any');

            axf_map = containers.Map('KeyType', 'int32', 'ValueType', 'any');
            axb_map = containers.Map('KeyType', 'int32', 'ValueType', 'any');
            ayf_map = containers.Map('KeyType', 'int32', 'ValueType', 'any');
            ayb_map = containers.Map('KeyType', 'int32', 'ValueType', 'any');
            azf_map = containers.Map('KeyType', 'int32', 'ValueType', 'any');        
            azb_map = containers.Map('KeyType', 'int32', 'ValueType', 'any');
                
            if(obj.type == 'C') 
                % set point map relations        
                dxf_map(0) = 1;  dyf_map(0) = 2;  dzf_map(0) = 4;
                dxf_map(1) = 0;  dyf_map(1) = 3;  dzf_map(1) = 5;
                dxf_map(2) = 3;  dyf_map(2) = 0;  dzf_map(2) = 6;
                dxf_map(3) = 2;  dyf_map(3) = 1;  dzf_map(3) = 7;
                dxf_map(4) = 5;  dyf_map(4) = 6;  dzf_map(4) = 0;
                dxf_map(5) = 4;  dyf_map(5) = 7;  dzf_map(5) = 1;    
                dxf_map(6) = 7;  dyf_map(6) = 4;  dzf_map(6) = 2;
                dxf_map(7) = 6;  dyf_map(7) = 5;  dzf_map(7) = 3;    

                axf_map = dxf_map;  ayf_map = dyf_map;  azf_map = dzf_map;
                axb_map = dxf_map;  ayb_map = dyf_map;  azb_map = dzf_map;
                dxb_map = dxf_map;  dyb_map = dyf_map;  dzb_map = dzf_map;

                obj.axf_map = axf_map;  obj.dxf_map = dxf_map;
                obj.axb_map = axb_map;  obj.dxb_map = dxb_map;
                obj.ayf_map = ayf_map;  obj.dyf_map = dyf_map;
                obj.ayb_map = ayb_map;  obj.dyb_map = dyb_map;
                obj.azf_map = azf_map;  obj.dzf_map = dzf_map;
                obj.azb_map = azb_map;  obj.dzb_map = dzb_map;
            end
        end

        function ierr = set_grid_size(obj,dx,dy,dz)
            dx_3d=repmat(dx,1,1,obj.dim(3));
            dy_3d=repmat(dy,1,1,obj.dim(3));
            dz_3d =zeros(obj.dim(1), obj.dim(2), obj.dim(3)); 
            for k=1:obj.dim(3)
                dz_3d(:,:,k) =repmat(dz(k) , obj.dim(1), obj.dim(2));
            end

            if(obj.type == 'C') 
                % set dx, dy, dz for each point, i.e. point 0, 1, 2, 3, 7
                obj.dx_f_map(0) = AYB(AXB(dx_3d));
                obj.dy_f_map(0) = AYB(AXB(dy_3d));
                obj.dz_f_map(0) = AZF(dz_3d);

                obj.dx_f_map(1) = AYB(dx_3d);
                obj.dy_f_map(1) = AYB(dy_3d);
                obj.dz_f_map(1) = AZF(dz_3d);

                obj.dx_f_map(2) = AXB(dx_3d);
                obj.dy_f_map(2) = AXB(dy_3d);
                obj.dz_f_map(2) = AZF(dz_3d);

                obj.dx_f_map(3) = dx_3d;
                obj.dy_f_map(3) = dy_3d;
                obj.dz_f_map(3) = AZF(dz_3d);
                
                obj.dx_f_map(7) = dx_3d;
                obj.dy_f_map(7) = dy_3d;
                obj.dz_f_map(7) = dz_3d;

                obj.dx_b_map(0) = shift(AYB(AXB(dx_3d)), -1, 1);
                obj.dy_b_map(0) = shift(AYB(AXB(dy_3d)), -1, 2);
                obj.dz_b_map(0) = shift(AZF(dz_3d), -1, 3);

                obj.dx_b_map(1) = shift(AYB(dx_3d), -1, 1);
                obj.dy_b_map(1) = shift(AYB(dy_3d), -1, 2);
                obj.dz_b_map(1) = shift(AZF(dz_3d), -1, 3);

                obj.dx_b_map(2) = shift(AXB(dx_3d), -1, 1);
                obj.dy_b_map(2) = shift(AXB(dy_3d), -1, 2);
                obj.dz_b_map(2) = shift(AZF(dz_3d), -1, 3);

                obj.dx_b_map(3) = shift(dx_3d,      -1, 1);
                obj.dy_b_map(3) = shift(dy_3d,      -1, 2);
                obj.dz_b_map(3) = shift(AZF(dz_3d), -1, 3);

                obj.dx_b_map(7) = shift(dx_3d, -1, 1);
                obj.dy_b_map(7) = shift(dy_3d, -1, 2);
                obj.dz_b_map(7) = shift(dz_3d, -1, 3);
                
                 % set area for each point
                art=obj.dx_f_map(3) .* obj.dy_f_map(3);
                arv=obj.dx_f_map(1) .* obj.dy_f_map(1);
                aru=obj.dx_f_map(2) .* obj.dy_f_map(2);
                arc=obj.dx_f_map(0) .* obj.dy_f_map(0);
                
                aru(1,:,:)=aru(2,:,:);
                aru(:,1,:)=aru(:,2,:);
                arv(1,:,:)=arv(2,:,:);
                arv(:,1,:)=arv(:,2,:);
                arc(1,:,:)=arc(2,:,:);
                arc(:,1,:)=arc(:,2,:);
                
                obj.area_map(0)=arc;
                obj.area_map(1)=arv;
                obj.area_map(2)=aru;                
                obj.area_map(3)=art;  
                obj.area_map(4)=arc;  
                obj.area_map(5)=arv;  
                obj.area_map(6)=aru;  
                obj.area_map(7)=art;
            end

            obj.grid_size_initialized = true;
            ierr=true;
        end   
  
        
        function ierr = set_grid_mask(obj,fsm)         
            % setup velocity masks
            for j=2:obj.dim(2)
                for i=2:obj.dim(1)
                    dum(i,j)=fsm(i,j)*fsm(i-1,j);
                    dvm(i,j)=fsm(i,j)*fsm(i,j-1);
                end
            end
    
            fsm_3d=repmat(fsm,1,1,obj.dim(3));                        
            dum_3d=repmat(dum,1,1,obj.dim(3));                    
            dvm_3d=repmat(dvm,1,1,obj.dim(3));

            if(obj.type == 'C') 
                % set dx, dy, dz for each point, i.e. point 0, 1, 2, 3, 7
                obj.mask_map(0) = dum_3d .* dvm_3d;
                obj.mask_map(1) = dvm_3d;
                obj.mask_map(2) = dum_3d;
                obj.mask_map(3) = fsm_3d;
                obj.mask_map(4) = dum_3d .* dvm_3d;
                obj.mask_map(5) = dvm_3d;
                obj.mask_map(6) = dum_3d;
                obj.mask_map(7) = fsm_3d;            
            end

            obj.grid_mask_initialized = true;
            ierr=true;
        end   
  
        
        function r = dx_f(obj, pos)
            r = obj.dx_f_map(pos);
        end
        function r = dy_f(obj, pos)
            r = obj.dy_f_map(pos);
        end
        function r = dz_f(obj, pos)
            r = obj.dz_f_map(pos);
        end
        
        function r = dx_b(obj, pos)
            r = obj.dx_b_map(pos);
        end
        function r = dy_b(obj, pos)
            r = obj.dy_b_map(pos);
        end
        function r = dz_b(obj, pos)
            r = obj.dz_b_map(pos);
        end
        
        function r = area(obj, pos)
            r = obj.area_map(pos);
        end 
        
        function r = mask(obj, pos)
            r = obj.mask_map(pos);
        end 
        
    end
end
