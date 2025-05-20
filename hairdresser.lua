---Hairdresser
-- The essential hairdresser operations for crow
-- → 1: signal
-- → 2: operation
--   1: fold/wrap/clip →

FREQ = 1/2222

function init()
   public{t = 2} -- threshold

   output[1].slew = 0.0007
   output[2].slew = 0.0007

   input[1]{mode = 'stream'
	    ,stream = function(v) output[1].volts = fold(v) end
	    ,time = FREQ
	   }
   input[2]{mode = 'window'
	    ,windows = {0, 2, 4}
	    ,window = function(w)
	       if w == 2 then
		  print("fold")
		  input[1].stream = function(v) output[1].volts = fold(v) end
	       elseif w == 3 then
		  print("wrap")
		  input[1].stream = function(v) output[1].volts = wrap(v) end
	       elseif w == 4 then
		  print("clip")
		  input[1].stream = function(v) output[1].volts = clip(v) end
	       else
		  print("window "..w)
	       end
	    end
	   }
end

function fold(v)
   if v < public.t and v > -public.t then
      return v
   else
      local t = public.t
      if v < 0 then t = t*-1 end
      return fold(t - (v - t))
   end
end

function wrap(v)
   if v < public.t and v > -public.t then
      return v
   else
      local t = public.t
      if v < 0 then t = t*-1 end
      return wrap(-t + (v-t))
   end
end

function clip(v)
   local t = public.t
   return math.max(-t, math.min(v, t))
end
