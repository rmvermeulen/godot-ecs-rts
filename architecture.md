# Architecture

The main game logic is implemented using gs-ecs. The components/, entities/, and systems/ folders house related files.
The rest is in src/.

# Global events
The `Events` singleton can be used to dispatch events that systems might be listening to. The coupling between specific actions and game events also happens here, e.g. mouse inputs.