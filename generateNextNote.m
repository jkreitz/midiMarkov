function newNote = generateNextNote(seed,markovTable)
% Outputs a stochastically-generated note from Markov probability table
% 
% Inputs:
%  seed - a k-tuple representing a key in markovTable 
%  markovTable - probability table as generated using trainMidiMarkov.m
% 
% Ouput: 
%  newNote - a value representing a note (middle C = 60)
%
% Copyright (c) 2017 Joseph Kreitz (joekreitz@gmail.com)
% Acknowledgement: utilizes Ken Schutte's midi read/write package
% (http://www.kenschutte.com/midi)

    weightedList = [];    
    val = markovTable(seed);
    charMap = val{2};
    charMapKeys = keys(charMap);
    for m = 1:1:numel(keys(charMap))
        weightedList = [weightedList repmat([charMapKeys{m}],1,charMap(charMapKeys{m}))];
    end
    
    newNote = weightedList(randi([1 numel(weightedList)])); 
end