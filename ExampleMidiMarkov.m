% An example implementation of midiMarkov to generate a stylistically-similar 
% permutation of a training sequence (in this case, the clarinet part from 
% Mozart's trio for clarinet, viola, and piano in E-flat). 

clear;
close all; 

% Convert training midi file to a matrix
trainingMidi = readmidi('mozart_trio_for_bb_clarinet.mid');
notes = midiInfo(trainingMidi,0); 

% Generate training tables to represent a Markov chain of order 2
probTable = trainMidiMarkov(notes,2);
lengthsTable = trainLengths(notes); 

% Generate a marix representing a new sequence using the training tables
newSong = generateNewSeq(probTable,lengthsTable,notes,2,100);

% Generate, display, and write midi
newSongMidi = matrix2midi(newSong);
displayMIDI(midiInfo(newSongMidi,0));
writemidi(newSongMidi, 'markovMidiExample.mid');

% ...Now play with it in Finale, a step sequencer, or any DAW! 

