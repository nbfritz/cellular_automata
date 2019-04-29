Cellular Automata
=================

_Well, technically, Conway's Game of Life, so far..._

Back when I was a kid, I did a rough implementation of Conway's Game of Life after reading
about it in a magazine (Dr. Dobb's Journal, I believe.) It had originally been popularized
in 1970 in an issue of Scientific American, but it was an intriguing concept to play with.

Fast forward, and I had an itch to implement that code in Ruby, just to see how it would
compare to my memories. **And it's still fun.**

Seriously. Go read about Cellular Automata and Conway's Game of Life. It came out of ideas
that really smart guys who met building the atomic bomb tinkered with. Fascinating stuff.

This is a rudimentary implementation of the rendering logic, but the game logic feels 
pretty solid.

- Pull in the dependencies with `bundler install`
- Kick off the test suite with `bin/rake` or `bin/rerun` if you want it to continuously 
  re-run on file changes.
- See it run with `bin/rake run` which will list the valid seeds. Run for real with something
  like `bin/rake run SEED=blinker`
