## Making the rhythm

- So i have my song chosen. In the first song i just downloaded a song so I need to figure out the BPM and add a count down before the song starts
    - For this I can either just prepend the count down to the track itself or have some kind of reusable countdown that you can change the BPM for
    - I don't like the second idea because then I have to make sure it's perfectly synced up with the song to not cause confusion

- I also have to make the TV track and player track
    - I think I am going to make a debug record mode on the level. So that I can record each track along side the song.
    - I'm wondering what that track would look like. We know how far along we are in the song when I press the button.
        - Maybe a list of timestamps. For the TV, in _process(), we check if we are at the next note in the list and when we are within some window we clap. For the player we can just check on press.
        - If they miss a note or just stop playing then it will be out of sync
        - Maybe the checking of the note for the player will happen in _process too so it knows where the player should be. Then on action we see how close we are to the closest note
    - Maybe store the tracks metadata in a JSON file.
        - Track Name
            - BPM
            - Song Path
            - Player Track
            - Instructor Track
- Replaying the tracks
    - To do this I'm probably going to constantly check our current progress in the song. When it is >= to the next note, we "play" it and increment to the next note.