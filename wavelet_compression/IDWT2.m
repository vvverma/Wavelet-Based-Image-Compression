function x =IDWT2(a,h,v,d,varargin)
%IDWT2  Single-level inverse discrete 2-D wavelet transform.
% Check arguments.
msg = nargchk(5,11,nargin);
if ~isempty(msg)
    error('Wavelet:FunctionInput:NbArg',msg)
end
if isempty(a) && isempty(h) && isempty(v) && isempty(d), x = []; return; end
if ischar(varargin{1})
    [Lo_R,Hi_R] = wfilters(varargin{1},'r'); next = 2;
else
    Lo_R = varargin{1}; Hi_R = varargin{2};  next = 3;
end

% Check arguments for Size, Shift and Extension.
DWT_Attribute = getappdata(0,'DWT_Attribute');
if isempty(DWT_Attribute) , DWT_Attribute = dwtmode('get'); end
dwtEXTM = DWT_Attribute.extMode; % Default: Extension.
shift   = DWT_Attribute.shift2D; % Default: Shift.
sx = [];
k = next;
while k<=length(varargin)
    if ischar(varargin{k})
        switch varargin{k}
           case 'mode'  , dwtEXTM = varargin{k+1};
           case 'shift' , shift = mod(varargin{k+1},2);
        end
        k = k+2;
    else
        sx = varargin{k};
        k = k+1;
    end
end
x = upsconv2(a,{Lo_R,Lo_R},sx,dwtEXTM,shift)+ ... % Approximation.
    upsconv2(h,{Hi_R,Lo_R},sx,dwtEXTM,shift)+ ... % Horizontal Detail.
    upsconv2(v,{Lo_R,Hi_R},sx,dwtEXTM,shift)+ ... % Vertical Detail.
    upsconv2(d,{Hi_R,Hi_R},sx,dwtEXTM,shift);     % Diagonal Detail.

