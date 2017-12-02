function newKey = generateNewKey(notes,level,k)
% Outputs a new key to be inputted into Markov probability table 
%
% Inputs:
%   notes - matrix representation of the entire training sequence (output from midiInfo)
%   level - current note in the training sequence (i.e. current row in notes)
%   k - order of Markov chain
% 
% Output: 
%   newKey - string of the form 'note1,note2,...,noteK' 
%
% Copyright (c) 2017 Joseph Kreitz (joekreitz@gmail.com)
% Acknowledgement: utilizes Ken Schutte's midi read/write package
% (http://www.kenschutte.com/midi)

    newKey = ''; 
    for i = 0:1:k-2
        newKey = [newKey num2str(notes(level+i,3)) ','];        
    end
    newKey = [newKey num2str(notes(level+k-1,3))];
end