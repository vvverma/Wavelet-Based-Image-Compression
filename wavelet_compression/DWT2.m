function [a,h,v,d] = DWT2(x,varargin)
%DWT2 Single-level discrete 2-D wavelet transform.

% Check arguments.
nbIn = nargin;
msg = nargchk(2,7,nbIn);
if ~isempty(msg)
    error('Wavelet:FunctionInput:NbArg',msg)
end
if ischar(varargin{1})
    [Lo_D,Hi_D] = wfilters(varargin{1},'d'); next = 2;
else
    Lo_D = varargin{1}; Hi_D = varargin{2};  next = 3;
end

% Check arguments for Extension and Shift.
DWT_Attribute = getappdata(0,'DWT_Attribute');
if isempty(DWT_Attribute) , DWT_Attribute = dwtmode('get'); end
dwtEXTM = DWT_Attribute.extMode; % Default: Extension.
shift   = DWT_Attribute.shift2D; % Default: Shift.
for k = next:2:nbIn-1
    switch varargin{k}
      case 'mode'  , dwtEXTM = varargin{k+1};
      case 'shift' , shift   = mod(varargin{k+1},2);
    end
end

% Compute sizes.
lf = length(Lo_D);
sx = size(x);

% Extend, Decompose &  Extract coefficients.
first = 2-shift;
flagPer = isequal(dwtEXTM,'per');
if ~flagPer
    sizeEXT = lf-1; last = sx+lf-1;
else
    sizeEXT = lf/2; last = 2*ceil(sx/2);
end

x = double(x);
if length(sx)==2
    y = wextend('addcol',dwtEXTM,x,sizeEXT);
    z = conv2(y,Lo_D(:)','valid');
    a = convdown(z,Lo_D,dwtEXTM,sizeEXT,first,last);
    h = convdown(z,Hi_D,dwtEXTM,sizeEXT,first,last);
    z = conv2(y,Hi_D(:)','valid');
    v = convdown(z,Lo_D,dwtEXTM,sizeEXT,first,last);
    d = convdown(z,Hi_D,dwtEXTM,sizeEXT,first,last);
else
    a = cell(0,3);
    h = cell(0,3);
    v = cell(0,3);
    d = cell(0,3);
    for k = 1:3
        y = wextend('addcol',dwtEXTM,x(:,:,k),sizeEXT);
        z = conv2(y,Lo_D(:)','valid');
        a{k} = convdown(z,Lo_D,dwtEXTM,sizeEXT,first,last);
        h{k} = convdown(z,Hi_D,dwtEXTM,sizeEXT,first,last);
        z = conv2(y,Hi_D(:)','valid');
        v{k} = convdown(z,Lo_D,dwtEXTM,sizeEXT,first,last);
        d{k} = convdown(z,Hi_D,dwtEXTM,sizeEXT,first,last);
    end
    a = cat(3,a{:});
    h = cat(3,h{:});
    v = cat(3,v{:});
    d = cat(3,d{:});
end

%-------------------------------------------------------%
% Internal Function(s)
%-------------------------------------------------------%
function y = convdown(x,F,dwtEXTM,lenEXT,first,last)

y = x(:,first(2):2:last(2));
y = wextend('addrow',dwtEXTM,y,lenEXT);
y = conv2(y',F(:)','valid');
y = y';
y = y(first(1):2:last(1),:);
%-------------------------------------------------------%
