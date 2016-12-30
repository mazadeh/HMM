% hmm_path:

global HMM_PATH
global PATH_SEPARATOR
global MATLAB_PATH_SEPARATOR
		
Friend = computer;

if strcmp(Friend,'MAC2'),
  PATH_SEPARATOR = ':';
  HMM_PATH = ['Macintosh HD:Build 802:BMIALab', PATH_SEPARATOR];
  MATLAB_PATH_SEPARATOR = ';';
elseif isunix,
  PATH_SEPARATOR = '/';
  HMM_PATH = [pwd, PATH_SEPARATOR];
  MATLAB_PATH_SEPARATOR = ':';
elseif strcmp(Friend(1:2),'PC');
  PATH_SEPARATOR = '\';	  
  HMM_PATH = [pwd, PATH_SEPARATOR];  
  MATLAB_PATH_SEPARATOR = ';';
end

post = PATH_SEPARATOR;
p = path;
pref = [MATLAB_PATH_SEPARATOR HMM_PATH];
p = [p pref];

p = [p pref 'data' post];
p = [p pref 'data' post 'train' post ];
p = [p pref 'data' post 'test' post];

path(p);

disp('HMM Path added successfully.');

clear p pref post
clear Friend
clear HMM_PATH MATLAB_PATH_SEPARATOR
% clear PATH_SEPARATOR