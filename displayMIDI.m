function displayMIDI(Notes)

%% compute piano-roll:
[PR,t,nn] = piano_roll(Notes);

%% display piano-roll:
figure;
imagesc(t,nn,PR);
axis xy;
xlabel('time (sec)');
ylabel('note number');

%% also, can do piano-roll showing velocity:
[PR,t,nn] = piano_roll(Notes,1);

figure;
imagesc(t,nn,PR);
axis xy;
xlabel('time (sec)');
ylabel('note number');