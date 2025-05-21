---Hairdresser
-- The essential hairdresser operations for crow
-- → 1: signal
-- → 2: operation; negative boosted fold
--   1: fold/wrap/clip/shampoo/rinse →
--   2:                shampoo       →

FREQ = 1/2222

Hairdresser = {}

function Hairdresser:fold(v)
   if v <= public.thresh and v >= -public.thresh then
      return v
   else
      local t = public.thresh
      if v < 0 then t = t*-1 end
      return Hairdresser:fold(t - (v - t))
   end
end

function Hairdresser:wrap(v)
   if v <= public.thresh and v >= -public.thresh then
      return v
   else
      local t = public.thresh
      if v < 0 then t = t*-1 end
      return Hairdresser:wrap(-t + (v-t))
   end
end

function Hairdresser:clip(v)
   local t = public.thresh
   return math.max(-t, math.min(v, t))
end

function Hairdresser:shampoo(v)
   return v
end

function Hairdresser:rinse()
   return 0
end

H = Hairdresser

function init()
   public{thresh = 2}:range(0.1, 10)
   public{boost  = 4}:range(1.5, 6)

   output[1].slew = 0.0007
   output[2].slew = 0.0007

   input[1]{mode = 'stream'
	    ,stream = function(v) output[1].volts = H:fold(v) end
	    ,time = FREQ
	   }
   input[2]{mode = 'window'
	    ,windows = {0, 1, 2, 3, 4}
	    ,window = function(w)
	       if w == 1 then
		  print("neg fold")
		  input[1].mode('stream')
		  input[1].stream = function(v)
		     output[1].volts = H:fold(v*public.boost)
		  end
	       elseif w == 2 then
		  print("fold")
		  input[1].mode('stream')
		  input[1].stream = function(v)
		     output[1].volts = H:fold(v)
		  end
	       elseif w == 3 then
		  print("wrap")
		  input[1].mode('stream')
		  input[1].stream = function(v)
		     output[1].volts = H:wrap(v)
		  end
	       elseif w == 4 then
		  print("clip")
		  input[1].mode('stream')
		  input[1].stream = function(v)
		     output[1].volts = H:clip(v)
		  end
	       elseif w == 5 then
		  print("shampoo")
		  input[1].stream = function(v)
		     output[1].volts = H:shampoo(v)
		     output[2].volts = H:shampoo(v)
		     input[1].mode('none')
		  end
	       elseif w == 6 then
		  print("rinse")
		  input[1].mode('stream')
		  input[1].stream = function(v)
		     output[1].volts = H:rinse()
		  end
	       else
		  print("window "..w)
	       end
	    end
	   }
end

-- erm, a cobbled mess because there is no require in druid
return Hairdresser
