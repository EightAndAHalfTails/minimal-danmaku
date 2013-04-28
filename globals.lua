module(...,package.seeall)

MAX_X = 500
MAX_Y = 900

keymap = {
   pause = 'escape',
   shoot = 'z',
   bomb = 'x',
   mute = 'm'
}

paused = false

enemies    = {}
bullets    = {}
explosions = {}