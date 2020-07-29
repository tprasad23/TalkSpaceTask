Architecture and Programming Choices:

- MVVM (model view view model)
- I opted to use dependency injected closures for communicating between View Controllers, vs protocol delegation. this was chosen for clarity (to see all dependencies in one place)
- Push Navigation and UITableView to present drawings
- Drawings are stored with custom codable classes, using JSON Encoding/Decoding
- I kept "presentation mode" connected to the ViewController/DrawPadView only (not managed by the view model), as it was a pure UI property, and once decided , wouldn't change for the particular session (i.e. the Draw Pad View could either only be in one or the other)
- Playback happens instantly, With further time I would investigate how to introduce delay, or Core Animation to animate the drawing of the stored paths.
- Eraser selection would inherit any existing line width selection previously made.
- Assumed that all drawings would be under 60 minutes, provided time in mins and seconds

Further developments

- Use Bezier Curves for draw/playback
- Animate Playback (using bezier curves) 
- Add more shape types for brush stroke
- Allow Editing in Playback mode (after image has been played fully)
- Use Diffable Data Source to manage the UITableView (iOS 13 introduction)

