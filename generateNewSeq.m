function newSong = generateNewSeq(markovTable,lengthsMap,notes,modelOrder,songLength)
% Outputs a novel midi sequence (in matrix form) using a Markov probability
% table 
% 
% Inputs: 
%   markovTable - output of trainMidiMarkov.m, of the following form: 
%       keys: strings of the form 'note1,note2,...,notek'
%       vals: cell arrays of the form {[count],[subMap]} 
%           -where count is the number of occurrences of the corresponing
%           key in the training data (note1,note2,...,notek)
%           -and subMap is a map containing counts for all k+1-sized tuples
%           with the first k notes equal to the corresponding key 
%           (note1,note2,...,notek,notek+1)
%   lengthsMap - output of trainLengths.m, of the following form: 
%   notes - training sequence; output of midiInfo(readmidi(file),0)
%   modelOrder - order of the Markov chain (i.e. number of notes in a key 
%        in markovTable)
%   songLength - number of notes desired in the new midi sequence
% 
% Output: 
%   newSong - matrix representation of new midi sequence, where each row
%   represents a single note. Each note has the following attributes: 
%       (1) Track number
%       (2) Channel number
%       (3) Note (60 = middle C)
%       (4) Velocity 
%       (5) Start time
%       (6) End time
%
% Copyright (c) 2017 Joseph Kreitz (joekreitz@gmail.com)
% Acknowledgement: utilizes Ken Schutte's midi read/write package
% (http://www.kenschutte.com/midi)

newSong = zeros(songLength,6);

seed = generateNewKey(notes,randi([1,size(notes,1)-modelOrder]),modelOrder); % Start from random location in song
startTime = 0.5; % Start at time 0.5
disp('Generating new song')
for n = 1:1:songLength
    % Generate a new note using trained Markov table
    
    nextNote = generateNextNote(seed,markovTable); 
    
    lengthsPossible = lengthsMap(nextNote);
    nextLength = lengthsPossible(randi([1,numel(lengthsPossible)]));
    
    % Add new note to existing stream
    nextNoteFull = zeros(1,6);           % To fit same format as matrix2midi.m
    nextNoteFull(1) = 1;                 % all in track 1
    nextNoteFull(2) = 1;                 % all in channel 1
    nextNoteFull(3) = nextNote;          % Markov-generated new note
    nextNoteFull(4) = randi([40,100]);                % volume
    nextNoteFull(5) = startTime;         % Each note lasts 0.5 seconds 
    nextNoteFull(6) = startTime + nextLength;   
    
    newSong(n,:) = nextNoteFull;
    
    startTime = startTime + nextLength; % Update startTime for next iteration
    
    % Construct new Markov seed with added nextNote
    existingSeed = strsplit(seed,',');
    newSeedCells = [existingSeed(2:end) num2str(nextNote)];
    newSeed = [];
    for i = 1:numel(newSeedCells)
        newSeed = [newSeed ',' newSeedCells{i}];
    end 
    seed = newSeed(2:end);
end

end 