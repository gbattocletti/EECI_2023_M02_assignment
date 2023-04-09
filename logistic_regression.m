classdef logistic_regression
    %LOGISTIC_REGRESSION Define a logistic regression cost

    properties
        A
    end
    properties
        B
    end
    properties
        w
    end
    properties (Access = private)
        AB
    end
    properties
        sm
    end

    methods
        function obj = logistic_regression(A, B, w)
            %LOGISTIC_REGRESSION Construct a logistic regression function

            obj.A = A; obj.B = B;
            obj.AB = - A.*B;

            % weight of optional regularization
            if exist('w','var')
                obj.w = w;
            else
                obj.w = 0;
            end

            % store an upper bound to the smoothness modulus (Lipschitz
            % continuity constant of the gradient)
            obj.sm = (1/4) * max(vecnorm(A')) * size(A,1);

        end

        function f = func(obj, x)
            %FUNC Evaluate the cost function at x

            f = sum(log(1 + exp(obj.AB * x))) + 0.5*obj.w * norm(x)^2;

        end

        function g = grad(obj, x, r)
            %GRAD Evaluate the gradient at x
            
            if exist('r','var')
                S = randsample(size(obj.A,1),r)';
            else
                S = 1:size(obj.A,1);
            end


            g = zeros(size(obj.A, 2),1);
            for i = S
                
                g = g + logsig(obj.AB(i,:) * x) * obj.AB(i,:)';
            
            end
            g = g + obj.w*x;
            
        end
    end
end