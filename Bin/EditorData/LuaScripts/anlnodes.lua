-- Build ANL function from node graph
-- Node-graph UI
-- Instance data
-- Consists of opcodes. 
-- If opcode=="Parameter" then get the specified input parameter.
-- If opcode=="Function" then instantiate the given ANL function, with the specified array indices
require 'LuaScripts/tableshow'

-- Testing
nodetypes=
{
	constant=
	{
		inputs=
		{
		},
		instance={{op="Function", func="constant"}}
	},
	seed=
	{
		inputs=
		{
		},
		instance={{op="Function", func="seed"}}
	},
	add=
	{
		inputs=
		{
			{"value", "Value", 0.0},
			{"value", "Value", 0.0},
		},
		instance={{op="Parameter", param=1}, {op="Parameter", param=2}, {op="Function", func="add", indices={1,2}}}
	},
	subtract=
	{
		inputs=
		{
			{"value", "Value", 0.0},
			{"value", "Value", 0.0},
		},
		instance={{op="Parameter", param=1}, {op="Parameter", param=2}, {op="Function", func="subtract", indices={1,2}}}
	},
	multiply=
	{
		inputs=
		{
			{"value", "Value", 1.0},
			{"value", "Value", 1.0},
		},
		instance={{op="Parameter", param=1}, {op="Parameter", param=2}, {op="Function", func="multiply", indices={1,2}}}
	},
	divide=
	{
		inputs=
		{
			{"value", "Value", 0.0},
			{"value", "Value", 1.0},
		},
		instance={{op="Parameter", param=1}, {op="Parameter", param=2}, {op="Function", func="divide", indices={1,2}}}
	},
	pow=
	{
		inputs=
		{
			{"value", "Value", 0.0},
			{"value", "Value", 1.0},
		},
		instance={{op="Parameter", param=1}, {op="Parameter", param=2}, {op="Function", func="pow", indices={1,2}}}
	},
	minimum=
	{
		inputs=
		{
			{"value", "Value", 0.0},
			{"value", "Value", 0.0},
		},
		instance={{op="Parameter", param=1}, {op="Parameter", param=2}, {op="Function", func="minimum", indices={1,2}}}
	},
	maximum=
	{
		inputs=
		{
			{"value", "Value", 0.0},
			{"value", "Value", 0.0},
		},
		instance={{op="Parameter", param=1}, {op="Parameter", param=2}, {op="Function", func="maximum", indices={1,2}}}
	},
	bias=
	{
		inputs=
		{
			{"value", "Value", 0.0},
			{"value", "Bias", 0.5},
		},
		instance={{op="Parameter", param=1}, {op="Parameter", param=2}, {op="Function", func="bias", indices={1,2}}}
	},
	gain=
	{
		inputs=
		{
			{"value", "Value", 0.0},
			{"value", "Gain", 0.5},
		},
		instance={{op="Parameter", param=1}, {op="Parameter", param=2}, {op="Function", func="gain", indices={1,2}}}
	},
	step=
	{
		inputs=
		{
			{"value", "Value", 0.0},
			{"value", "Threshold", 0.0},
		},
		instance={{op="Parameter", param=1}, {op="Parameter", param=2}, {op="Function", func="step", indices={1,2}}}
	},
	linearStep=
	{
		inputs=
		{
			{"value", "Low", 0.0},
			{"value", "High", 1.0},
			{"value", "Control", 0.0},
		},
		instance={{op="Parameter", param=1}, {op="Parameter", param=2}, {op="Parameter", param=3}, {op="Function", func="linearStep", indices={1,2,3}}}
	},
	smoothStep=
	{
		inputs=
		{
			{"value", "Low", 0.0},
			{"value", "High", 1.0},
			{"value", "Control", 0.0},
		},
		instance={{op="Parameter", param=1}, {op="Parameter", param=2}, {op="Parameter", param=3}, {op="Function", func="smoothStep", indices={1,2,3}}}
	},
	smootherStep=
	{
		inputs=
		{
			{"value", "Low", 0.0},
			{"value", "High", 1.0},
			{"value", "Control", 0.0},
		},
		instance={{op="Parameter", param=1}, {op="Parameter", param=2}, {op="Parameter", param=3}, {op="Function", func="smootherStep", indices={1,2,3}}}
	},
	abs=
	{
		inputs=
		{
			{"value","Value",0.0}
		},
		instance={{op="Parameter", param=1}, {op="Function", func="abs", indices={1}}}
	},
	sin=
	{
		inputs=
		{
			{"value","Value",0.0}
		},
		instance={{op="Parameter", param=1}, {op="Function", func="sin", indices={1}}}
	},
	cos=
	{
		inputs=
		{
			{"value","Value",0.0}
		},
		instance={{op="Parameter", param=1}, {op="Function", func="cos", indices={1}}}
	},
	tan=
	{
		inputs=
		{
			{"value","Value",0.0}
		},
		instance={{op="Parameter", param=1}, {op="Function", func="tan", indices={1}}}
	},
	asin=
	{
		inputs=
		{
			{"value","Value",0.0}
		},
		instance={{op="Parameter", param=1}, {op="Function", func="asin", indices={1}}}
	},
	acos=
	{
		inputs=
		{
			{"value","Value",0.0}
		},
		instance={{op="Parameter", param=1}, {op="Function", func="acos", indices={1}}}
	},
	atan=
	{
		inputs=
		{
			{"value","Value",0.0}
		},
		instance={{op="Parameter", param=1}, {op="Function", func="atan", indices={1}}}
	},
	x=
	{
		inputs=
		{
		},
		instance={{op="Function", func="x", indices={}}}
	},
	y=
	{
		inputs=
		{
		},
		instance={{op="Function", func="y", indices={}}}
	},
	dx=
	{
		inputs=
		{
			{"value", "Value", 0.0},
			{"value", "Spacing", 0.01},
		},
		instance={{op="Parameter", param=1}, {op="Parameter", param=2}, {op="Function", func="dX", indices={1,2}}}
	},
	dy=
	{
		inputs=
		{
			{"value", "Value", 0.0},
			{"value", "Spacing", 0.01},
		},
		instance={{op="Parameter", param=1}, {op="Parameter", param=2}, {op="Function", func="dY", indices={1,2}}}
	},
	tiers=
	{
		inputs=
		{
			{"value", "Value", 0.0},
			{"value", "NumTiers", 1.0},
		},
		instance={{op="Parameter", param=1}, {op="Parameter", param=2}, {op="Function", func="tiers", indices={1,2}}}
	},
	smoothTiers=
	{
		inputs=
		{
			{"value", "Value", 0.0},
			{"value", "NumTiers", 1.0},
		},
		instance={{op="Parameter", param=1}, {op="Parameter", param=2}, {op="Function", func="smoothTiers", indices={1,2}}}
	},
	translateDomain=
	{
		inputs=
		{
			{"value", "Value", 0.0},
			{"value", "Amount", 0.0},
		},
		instance={{op="Parameter", param=1}, {op="Parameter", param=2}, {op="Function", func="translateDomain", indices={1,2}}}
	},
	translateX=
	{
		inputs=
		{
			{"value", "Value", 0.0},
			{"value", "Amount", 0.0},
		},
		instance={{op="Parameter", param=1}, {op="Parameter", param=2}, {op="Function", func="translateX", indices={1,2}}}
	},
	translateY=
	{
		inputs=
		{
			{"value", "Value", 0.0},
			{"value", "Amount", 1.0},
		},
		instance={{op="Parameter", param=1}, {op="Parameter", param=2}, {op="Function", func="translateY", indices={1,2}}}
	},
	scaleDomain=
	{
		inputs=
		{
			{"value", "Value", 0.0},
			{"value", "Amount", 1.0},
		},
		instance={{op="Parameter", param=1}, {op="Parameter", param=2}, {op="Function", func="scaleDomain", indices={1,2}}}
	},
	scaleX=
	{
		inputs=
		{
			{"value", "Value", 0.0},
			{"value", "Amount", 1.0},
		},
		instance={{op="Parameter", param=1}, {op="Parameter", param=2}, {op="Function", func="scaleX", indices={1,2}}}
	},
	scaleY=
	{
		inputs=
		{
			{"value", "Value", 0.0},
			{"value", "Amount", 1.0},
		},
		instance={{op="Parameter", param=1}, {op="Parameter", param=2}, {op="Function", func="scaleY", indices={1,2}}}
	},
	rotateDomain=
	{
		inputs=
		{
			{"value", "Value", 0.0},
			{"value", "Angle", 1.0},
			{"value", "AxisX", 0.0},
			{"value", "AxisY", 0.0},
			{"value", "Axisz", 1.0}
		},
		instance={{op="Parameter", param=1}, {op="Parameter", param=2}, {op="Parameter", param=3}, {op="Parameter", param=4}, {op="Parameter", param=5},
				{op="Function", func="rotateDomain", indices={1,2,3,4,5}}}
	},
	mix=
	{
		inputs=
		{
			{"value", "Low", 0.5},
			{"value", "High", 0.0},
			{"value", "Control", 1.0}
		},
		instance={{op="Parameter", param=1}, {op="Parameter", param=2}, {op="Parameter", param=3}, {op="Function", func="mix", indices={1,2,3}}}
	},
	seeder=
	{
		inputs=
		{
			{"seed", "Seed", 45678},
			{"value", "Input", 0.0},
		},
		instance={{op="Parameter", param=1}, {op="Parameter", param=2}, {op="Function", func="seeder", indices={1,2}}}
	},
	sigmoid=
	{
		inputs=
		{
			{"value", "Value", 0.0},
			{"value", "Center", 0.0},
			{"value", "Ramp", 1.0}
		},
		instance={{op="Parameter", param=1}, {op="Parameter", param=2}, {op="Parameter", param=3}, {op="Function", func="sigmoid", indices={1,2,3}}}
	},
	randomize=
	{
		inputs=
		{
			{"seed", "Seed", 17892},
			{"value", "Low", 0.0},
			{"value", "High", 1.0}
		},
		instance={{op="Parameter", param=1}, {op="Parameter", param=2}, {op="Parameter", param=3}, {op="Function", func="randomize", indices={1,2,3}}}
	},
	fractal=
	{
		inputs=
		{
			{"seed", "Seed", 17892},
			{"value", "Layer", 0.0},
			{"value", "Persistence", 0.5},
			{"value", "Lacunarity", 2.0},
			{"value", "Octaves", 8},
			{"value", "Frequency", 1.0},
		},
		instance={{op="Parameter", param=1}, {op="Parameter", param=2}, {op="Parameter", param=3}, {op="Parameter", param=4}, {op="Parameter", param=5},
				{op="Parameter", param=6}, {op="Function", func="fractal", indices={1,2,3,4,5,6}}}
	},
	cellularBasis=
	{
		inputs=
		{
			{"value", "F1", -1.0},
			{"value", "F2", 1.0},
			{"value", "F3", 0.0},
			{"value", "F4", 0.0},
			{"value", "D1", 0.0},
			{"value", "D2", 0.0},
			{"value", "D3", 0.0},
			{"value", "D4", 0.0},
			{"value", "Distance Func", 0},
			{"seed", "Seed", 91234},
		},
		instance={{op="Parameter", param=1}, {op="Parameter", param=2}, {op="Parameter", param=3}, {op="Parameter", param=4}, {op="Parameter", param=5},
				{op="Parameter", param=6}, {op="Parameter", param=7}, {op="Parameter", param=8}, {op="Parameter", param=9}, {op="Parameter", param=10},
				{op="Function", func="cellularBasis", indices={1,2,3,4,5,6,7,8,9,10}}}
	},
	valueBasis=
	{
		inputs=
		{
			{"value", "Interpolation", 3},
			{"seed", "Seed", 147234},
		},
		instance={{op="Parameter", param=1}, {op="Parameter", param=2}, {op="Function", func="valueBasis", indices={1,2}}}
	},
	gradientBasis=
	{
		inputs=
		{
			{"value", "Interpolation", 3},
			{"seed", "Seed", 147234},
		},
		instance={{op="Parameter", param=1}, {op="Parameter", param=2}, {op="Function", func="gradientBasis", indices={1,2}}}
	},
	simplexBasis=
	{
		inputs=
		{
			{"seed", "Seed", 7120345}
		},
		instance={{op="Parameter", param=1}, {op="Function", func="simplexBasis", indices={1}}}
	},
	radial=
	{
		inputs=
		{
		},
		instance={{op="Function", func="radial", indices={}}}
	},
	combineRGBA=
	{
		inputs=
		{
			{"value", "Red", 0.0},
			{"value", "Green", 0.0},
			{"value", "Blue", 0.0},
			{"value", "Alpha", 1.0},
		},
		instance={{op="Parameter", param=1}, {op="Parameter", param=2}, {op="Parameter", param=3}, {op="Parameter", param=4},
			{op="Function", func="combineRGBA", indices={1,2,3,4}}}
	},
	combineHSVA=
	{
		inputs=
		{
			{"value", "Hue", 0.0},
			{"value", "Sat", 1.0},
			{"value", "Value", 1.0},
			{"value", "Alpha", 1.0},
		},
		instance={{op="Parameter", param=1}, {op="Parameter", param=2}, {op="Parameter", param=3}, {op="Parameter", param=4},
			{op="Function", func="combineHSVA", indices={1,2,3,4}}}
	},
	user=
	{
	},
	library=
	{
	Test={
   ["instance"] = {
      [1] = {
         ["op"] = "Parameter";
         ["param"] = 1;
      };
      [2] = {
         ["op"] = "Function";
         ["seeds"] = {
            [1] = "nil";
            [2] = "nil";
            [3] = "nil";
            [4] = "nil";
            [5] = "nil";
            [6] = "nil";
            [7] = "nil";
            [8] = "nil";
            [9] = "nil";
            [10] = "nil";
         };
         ["func"] = "cellularBasis";
         ["indices"] = {
            [1] = "nil";
            [2] = "nil";
            [3] = "nil";
            [4] = "nil";
            [5] = "nil";
            [6] = "nil";
            [7] = "nil";
            [8] = "nil";
            [9] = "nil";
            [10] = 1;
         };
         ["constants"] = {
            [1] = -1;
            [2] = 1;
            [3] = 0;
            [4] = 0;
            [5] = 0;
            [6] = 0;
            [7] = 0;
            [8] = 0;
            [9] = 0;
            [10] = "nil";
         };
      };
      [3] = {
         ["op"] = "Parameter";
         ["param"] = 2;
      };
      [4] = {
         ["op"] = "Function";
         ["seeds"] = {
            [1] = "nil";
            [2] = "nil";
         };
         ["func"] = "scaleDomain";
         ["indices"] = {
            [1] = 2;
            [2] = 3;
         };
         ["constants"] = {
            [1] = "nil";
            [2] = "nil";
         };
      };
      [5] = {
         ["op"] = "Parameter";
         ["param"] = 3;
      };
      [6] = {
         ["op"] = "Function";
         ["seeds"] = {
            [1] = "nil";
            [2] = 147234;
         };
         ["func"] = "gradientBasis";
         ["indices"] = {
            [1] = "nil";
            [2] = "nil";
         };
         ["constants"] = {
            [1] = 3;
            [2] = "nil";
         };
      };
      [7] = {
         ["op"] = "Function";
         ["seeds"] = {
            [1] = "nil";
         };
         ["func"] = "abs";
         ["indices"] = {
            [1] = 6;
         };
         ["constants"] = {
            [1] = "nil";
         };
      };
      [8] = {
         ["op"] = "Function";
         ["seeds"] = {
            [1] = 17892;
            [2] = "nil";
            [3] = "nil";
         };
         ["func"] = "randomize";
         ["indices"] = {
            [1] = "nil";
            [2] = "nil";
            [3] = "nil";
         };
         ["constants"] = {
            [1] = "nil";
            [2] = 0;
            [3] = 3.14;
         };
      };
      [9] = {
         ["op"] = "Function";
         ["seeds"] = {
            [1] = "nil";
            [2] = "nil";
            [3] = "nil";
            [4] = "nil";
            [5] = "nil";
         };
         ["func"] = "rotateDomain";
         ["indices"] = {
            [1] = 7;
            [2] = 8;
            [3] = "nil";
            [4] = "nil";
            [5] = "nil";
         };
         ["constants"] = {
            [1] = "nil";
            [2] = "nil";
            [3] = 0;
            [4] = 0;
            [5] = 1;
         };
      };
      [10] = {
         ["op"] = "Parameter";
         ["param"] = 4;
      };
      [11] = {
         ["op"] = "Function";
         ["seeds"] = {
            [1] = 17892;
            [2] = "nil";
            [3] = "nil";
            [4] = "nil";
            [5] = "nil";
            [6] = "nil";
         };
         ["func"] = "fractal";
         ["indices"] = {
            [1] = "nil";
            [2] = 9;
            [3] = "nil";
            [4] = "nil";
            [5] = "nil";
            [6] = 10;
         };
         ["constants"] = {
            [1] = "nil";
            [2] = "nil";
            [3] = 0.5;
            [4] = 2;
            [5] = 8;
            [6] = "nil";
         };
      };
      [12] = {
         ["op"] = "Parameter";
         ["param"] = 5;
      };
      [13] = {
         ["op"] = "Function";
         ["seeds"] = {
            [1] = "nil";
            [2] = "nil";
         };
         ["func"] = "multiply";
         ["indices"] = {
            [1] = 11;
            [2] = 12;
         };
         ["constants"] = {
            [1] = "nil";
            [2] = "nil";
         };
      };
      [14] = {
         ["op"] = "Function";
         ["seeds"] = {
            [1] = "nil";
            [2] = "nil";
         };
         ["func"] = "seeder";
         ["indices"] = {
            [1] = 5;
            [2] = 13;
         };
         ["constants"] = {
            [1] = "nil";
            [2] = "nil";
         };
      };
      [15] = {
         ["op"] = "Function";
         ["seeds"] = {
            [1] = "nil";
            [2] = "nil";
         };
         ["func"] = "translateX";
         ["indices"] = {
            [1] = 4;
            [2] = 14;
         };
         ["constants"] = {
            [1] = "nil";
            [2] = "nil";
         };
      };
      [16] = {
         ["op"] = "Function";
         ["seeds"] = {
            [1] = "nil";
            [2] = "nil";
         };
         ["func"] = "add";
         ["indices"] = {
            [1] = 5;
            [2] = "nil";
         };
         ["constants"] = {
            [1] = "nil";
            [2] = 10;
         };
      };
      [17] = {
         ["op"] = "Function";
         ["seeds"] = {
            [1] = "nil";
            [2] = "nil";
         };
         ["func"] = "seeder";
         ["indices"] = {
            [1] = 16;
            [2] = 13;
         };
         ["constants"] = {
            [1] = "nil";
            [2] = "nil";
         };
      };
      [18] = {
         ["op"] = "Function";
         ["seeds"] = {
            [1] = "nil";
            [2] = "nil";
         };
         ["func"] = "translateY";
         ["indices"] = {
            [1] = 15;
            [2] = 17;
         };
         ["constants"] = {
            [1] = "nil";
            [2] = "nil";
         };
      };
   };
   ["inputs"] = {
      [1] = {
         [1] = "seed";
         [2] = "CllSd";
         [3] = 12345;
      };
      [2] = {
         [1] = "value";
         [2] = "CllFrq";
         [3] = 8;
      };
      [3] = {
         [1] = "seed";
         [2] = "TrbSd";
         [3] = 12345;
      };
      [4] = {
         [1] = "value";
         [2] = "TrbFrq";
         [3] = 4;
      };
      [5] = {
         [1] = "value";
         [2] = "TrbPwr";
         [3] = 0.2;
      };
   };
},
fuzzydisk= {
   ["instance"] = {
      [1] = {
         ["op"] = "Parameter";
         ["param"] = 1;
      };
      [2] = {
         ["op"] = "Function";
         ["seeds"] = {};
         ["func"] = "radial";
         ["indices"] = {};
         ["constants"] = {};
      };
      [3] = {
         ["op"] = "Function";
         ["seeds"] = {
            [1] = "nil";
            [2] = "nil";
         };
         ["func"] = "translateX";
         ["indices"] = {
            [1] = 2;
            [2] = "nil";
         };
         ["constants"] = {
            [1] = "nil";
            [2] = -0.5;
         };
      };
      [4] = {
         ["op"] = "Function";
         ["seeds"] = {
            [1] = "nil";
            [2] = "nil";
         };
         ["func"] = "translateY";
         ["indices"] = {
            [1] = 3;
            [2] = "nil";
         };
         ["constants"] = {
            [1] = "nil";
            [2] = -0.5;
         };
      };
      [5] = {
         ["op"] = "Function";
         ["seeds"] = {
            [1] = "nil";
            [2] = "nil";
         };
         ["func"] = "subtract";
         ["indices"] = {
            [1] = 1;
            [2] = 4;
         };
         ["constants"] = {
            [1] = "nil";
            [2] = "nil";
         };
      };
      [6] = {
         ["op"] = "Function";
         ["seeds"] = {
            [1] = "nil";
            [2] = "nil";
         };
         ["func"] = "divide";
         ["indices"] = {
            [1] = 5;
            [2] = 1;
         };
         ["constants"] = {
            [1] = "nil";
            [2] = "nil";
         };
      };
      [7] = {
         ["op"] = "Function";
         ["seeds"] = {
            [1] = "nil";
            [2] = "nil";
         };
         ["func"] = "minimum";
         ["indices"] = {
            [1] = 6;
            [2] = "nil";
         };
         ["constants"] = {
            [1] = "nil";
            [2] = 1;
         };
      };
      [8] = {
         ["op"] = "Function";
         ["seeds"] = {
            [1] = "nil";
            [2] = "nil";
         };
         ["func"] = "maximum";
         ["indices"] = {
            [1] = 7;
            [2] = "nil";
         };
         ["constants"] = {
            [1] = "nil";
            [2] = 0;
         };
      };
   };
   ["inputs"] = {
      [1] = {
         [1] = "value";
         [2] = "Radius";
         [3] = 0.5;
      };
   };
},
correct= {
   ["instance"] = {
      [1] = {
         ["op"] = "Parameter";
         ["param"] = 1;
      };
      [2] = {
         ["op"] = "Parameter";
         ["param"] = 2;
      };
      [3] = {
         ["op"] = "Function";
         ["seeds"] = {
            [1] = "nil";
            [2] = "nil";
         };
         ["func"] = "multiply";
         ["indices"] = {
            [1] = 1;
            [2] = 2;
         };
         ["constants"] = {
            [1] = "nil";
            [2] = "nil";
         };
      };
      [4] = {
         ["op"] = "Parameter";
         ["param"] = 3;
      };
      [5] = {
         ["op"] = "Function";
         ["seeds"] = {
            [1] = "nil";
            [2] = "nil";
         };
         ["func"] = "add";
         ["indices"] = {
            [1] = 3;
            [2] = 4;
         };
         ["constants"] = {
            [1] = "nil";
            [2] = "nil";
         };
      };
      [6] = {
         ["op"] = "Function";
         ["seeds"] = {
            [1] = "nil";
            [2] = "nil";
         };
         ["func"] = "minimum";
         ["indices"] = {
            [1] = 5;
            [2] = "nil";
         };
         ["constants"] = {
            [1] = "nil";
            [2] = 1;
         };
      };
      [7] = {
         ["op"] = "Function";
         ["seeds"] = {
            [1] = "nil";
            [2] = "nil";
         };
         ["func"] = "maximum";
         ["indices"] = {
            [1] = 6;
            [2] = "nil";
         };
         ["constants"] = {
            [1] = "nil";
            [2] = 0;
         };
      };
   };
   ["inputs"] = {
      [1] = {
         [1] = "value";
         [2] = "Input";
         [3] = 1;
      };
      [2] = {
         [1] = "value";
         [2] = "Scale";
         [3] = 1;
      };
      [3] = {
         [1] = "value";
         [2] = "Add";
         [3] = 0;
      };
   };
},
distort={
   ["instance"] = {
      [1] = {
         ["op"] = "Parameter";
         ["param"] = 1;
      };
      [2] = {
         ["op"] = "Parameter";
         ["param"] = 2;
      };
      [3] = {
         ["op"] = "Function";
         ["seeds"] = {
            [1] = "nil";
            [2] = "nil";
         };
         ["func"] = "scaleDomain";
         ["indices"] = {
            [1] = 1;
            [2] = 2;
         };
         ["constants"] = {
            [1] = "nil";
            [2] = "nil";
         };
      };
      [4] = {
         ["op"] = "Parameter";
         ["param"] = 3;
      };
      [5] = {
         ["op"] = "Parameter";
         ["param"] = 4;
      };
      [6] = {
         ["op"] = "Parameter";
         ["param"] = 5;
      };
      [7] = {
         ["op"] = "Parameter";
         ["param"] = 6;
      };
      [8] = {
         ["op"] = "Function";
         ["seeds"] = {
            [1] = 17892;
            [2] = "nil";
            [3] = "nil";
            [4] = "nil";
            [5] = "nil";
            [6] = "nil";
         };
         ["func"] = "fractal";
         ["indices"] = {
            [1] = "nil";
            [2] = 5;
            [3] = "nil";
            [4] = "nil";
            [5] = 6;
            [6] = 7;
         };
         ["constants"] = {
            [1] = "nil";
            [2] = "nil";
            [3] = 0.5;
            [4] = 2;
            [5] = "nil";
            [6] = "nil";
         };
      };
      [9] = {
         ["op"] = "Parameter";
         ["param"] = 7;
      };
      [10] = {
         ["op"] = "Function";
         ["seeds"] = {
            [1] = "nil";
            [2] = "nil";
         };
         ["func"] = "multiply";
         ["indices"] = {
            [1] = 8;
            [2] = 9;
         };
         ["constants"] = {
            [1] = "nil";
            [2] = "nil";
         };
      };
      [11] = {
         ["op"] = "Function";
         ["seeds"] = {
            [1] = "nil";
            [2] = "nil";
         };
         ["func"] = "seeder";
         ["indices"] = {
            [1] = 4;
            [2] = 10;
         };
         ["constants"] = {
            [1] = "nil";
            [2] = "nil";
         };
      };
      [12] = {
         ["op"] = "Function";
         ["seeds"] = {
            [1] = "nil";
            [2] = "nil";
         };
         ["func"] = "translateX";
         ["indices"] = {
            [1] = 3;
            [2] = 11;
         };
         ["constants"] = {
            [1] = "nil";
            [2] = "nil";
         };
      };
      [13] = {
         ["op"] = "Parameter";
         ["param"] = 8;
      };
      [14] = {
         ["op"] = "Function";
         ["seeds"] = {
            [1] = "nil";
            [2] = "nil";
         };
         ["func"] = "seeder";
         ["indices"] = {
            [1] = 13;
            [2] = 10;
         };
         ["constants"] = {
            [1] = "nil";
            [2] = "nil";
         };
      };
      [15] = {
         ["op"] = "Function";
         ["seeds"] = {
            [1] = "nil";
            [2] = "nil";
         };
         ["func"] = "translateY";
         ["indices"] = {
            [1] = 12;
            [2] = 14;
         };
         ["constants"] = {
            [1] = "nil";
            [2] = "nil";
         };
      };
   };
   ["inputs"] = {
      [1] = {
         [1] = "value";
         [2] = "Source";
         [3] = 1;
      };
      [2] = {
         [1] = "value";
         [2] = "Source Size";
         [3] = 1;
      };
      [3] = {
         [1] = "seed";
         [2] = "XSeed";
         [3] = 56789;
      };
      [4] = {
         [1] = "value";
         [2] = "Distort Func";
         [3] = 1;
      };
      [5] = {
         [1] = "value";
         [2] = "Detail";
         [3] = 8;
      };
      [6] = {
         [1] = "value";
         [2] = "Distort Size";
         [3] = 1;
      };
      [7] = {
         [1] = "value";
         [2] = "Power";
         [3] = 0.1;
      };
      [8] = {
         [1] = "seed";
         [2] = "YSeed";
         [3] = 12345;
      };
   };
};
}
	
}

nodecategories=
{
	combine=
	{
		"add",
		"subtract",
		"multiply",
		"divide",
		"pow",
		"minimum",
		"maximum",
		"bias",
		"gain",
		"mix",
		"dx",
		"dy",
		"fractal",
	},
	scalarmath=
	{
		"abs",
		"sin",
		"cos",
		"tan",
		"asin",
		"acos",
		"atan",
		"sigmoid",
		"randomize",
	},
	step=
	{
		"step",
		"linearStep",
		"smoothStep",
		"smootherStep",
		"tiers",
		"smoothTiers",
	},
	basis=
	{
		"constant",
		"seed",
		"valueBasis",
		"gradientBasis",
		"simplexBasis",
		"cellularBasis",
		"x",
		"y",
		"radial",
		"seeder",
	},
	transform=
	{
		"scaleDomain",
		"scaleX",
		"scaleY",
		"translateDomain",
		"translateX",
		"translateY",
		"rotateDomain",
	},
	color=
	{
		"combineRGBA",
		"combineHSVA",
	},
	library=
	{
		--"Test",
		--"fuzzydisk",
		--"distort"
	},
	user=
	{
	}
	
}

local nm,nt
for nm,nt in pairs(nodetypes.library) do
	table.insert(nodecategories.library, nm)
end

for nm,nt in pairs(nodetypes.user) do
	table.insert(nodecategories.user, nm)
end

function InstanceFunction(k, desc, params)
	local ins=desc.instance
	if not ins then return end
	
	local n={}
	local c
	for _,c in ipairs(ins) do
		if c.op=="Parameter" then
			table.insert(n, params[c.param])
		elseif c.op=="Function" then
			local indices=c.indices
			local constants=c.constants
			local seeds=c.seeds
			
			local inputs={}
			local d
			
			local fdesc=GetNodeTypeDesc(c.func) --nodetypes[c.func]
			print("numinputs for "..c.func..": "..#fdesc.inputs)
			for d=1,#fdesc.inputs,1 do
				if indices[d] ~= "nil" then print("index: "..indices[d]) table.insert(inputs,n[indices[d]])
				elseif constants and constants[d] ~= "nil" then print("constant: "..constants[d]) table.insert(inputs, k:constant(constants[d]))
				elseif seeds and seeds[d] ~= "nil" then print("seed: "..seeds[d]) table.insert(inputs, k:seed(seeds[d]))
				end
			end
			
			print("Function name: "..c.func)
			if c.func=="add" then
				table.insert(n, k:add(inputs[1],inputs[2]))
			elseif c.func=="subtract" then
				table.insert(n, k:subtract(inputs[1], inputs[2]))
			elseif c.func=="multiply" then
				table.insert(n, k:multiply(inputs[1], inputs[2]))
			elseif c.func=="divide" then
				table.insert(n, k:divide(inputs[1], inputs[2]))
			elseif c.func=="subtract" then
				table.insert(n, k:subtract(inputs[1], inputs[2]))
			elseif c.func=="minimum" then
				table.insert(n, k:minimum(inputs[1], inputs[2]))
			elseif c.func=="maximum" then
				table.insert(n, k:maximum(inputs[1], inputs[2]))
			elseif c.func=="bias" then
				table.insert(n, k:bias(inputs[1], inputs[2]))
			elseif c.func=="gain" then
				table.insert(n, k:gain(inputs[1], inputs[2]))
			elseif c.func=="step" then
				table.insert(n, k:step(inputs[1], inputs[2]))
			elseif c.func=="linearStep" then
				table.insert(n, k:linearStep(inputs[1], inputs[2], inputs[3]))
			elseif c.func=="smoothStep" then
				table.insert(n, k:smoothStep(inputs[1], inputs[2], inputs[3]))
			elseif c.func=="smootherStep" then
				table.insert(n, k:smootherStep(inputs[1], inputs[2], inputs[3]))
			elseif c.func=="abs" then
				table.insert(n, k:abs(inputs[1]))
			elseif c.func=="sin" then
				table.insert(n, k:sin(inputs[1]))
			elseif c.func=="cos" then
				table.insert(n, k:cos(inputs[1]))
			elseif c.func=="tan" then
				table.insert(n, k:tan(inputs[1]))
			elseif c.func=="asin" then
				table.insert(n, k:asin(inputs[1]))
			elseif c.func=="acos" then
				table.insert(n, k:acos(inputs[1]))
			elseif c.func=="atan" then
				table.insert(n, k:atan(inputs[1]))
			elseif c.func=="x" then
				table.insert(n, k:x())
			elseif c.func=="y" then
				table.insert(n, k:y())
			elseif c.func=="radial" then
				table.insert(n, k:radial())
			elseif c.func=="dX" then
				table.insert(n, k:dx(inputs[1], inputs[2]))
			elseif c.func=="dY" then
				table.insert(n, k:dy(inputs[1], inputs[2]))
			elseif c.func=="smoothTiers" then
				table.insert(n, k:smoothTiers(inputs[1], inputs[2]))
			elseif c.func=="tiers" then
				table.insert(n, k:tiers(inputs[1], inputs[2]))
			elseif c.func=="translateDomain" then
				table.insert(n, k:translateDomain(inputs[1], inputs[2]))
			elseif c.func=="translateX" then
				table.insert(n, k:translateX(inputs[1], inputs[2]))
			elseif c.func=="translateY" then
				table.insert(n, k:translateY(inputs[1], inputs[2]))
			elseif c.func=="scaleDomain" then
				table.insert(n, k:scaleDomain(inputs[1], inputs[2]))
			elseif c.func=="scaleX" then
				table.insert(n, k:scaleX(inputs[1], inputs[2]))
			elseif c.func=="scaleY" then
				table.insert(n, k:scaleY(inputs[1], inputs[2]))
			elseif c.func=="rotateDomain" then
				table.insert(n, k:rotateDomain(inputs[1], inputs[2], inputs[3], inputs[4], inputs[5]))
			elseif c.func=="mix" then
				table.insert(n, k:mix(inputs[1], inputs[2], inputs[3]))
			elseif c.func=="seeder" then
				table.insert(n, k:seeder(inputs[1], inputs[2]))
			elseif c.func=="sigmoid" then
				table.insert(n, k:sigmoid(inputs[1], inputs[2], inputs[3]))
			elseif c.func=="randomize" then
				table.insert(n, k:randomize(inputs[1], inputs[2], inputs[3]))
			elseif c.func=="fractal" then
				table.insert(n, k:fractal(inputs[1], inputs[2], inputs[3], inputs[4], inputs[5], inputs[6]))
			elseif c.func=="cellularBasis" then
				table.insert(n, k:cellularBasis(inputs[1], inputs[2], inputs[3], inputs[4], inputs[5], inputs[6], inputs[7], inputs[8], inputs[9], inputs[10]))
			elseif c.func=="valueBasis" then
				table.insert(n, k:valueBasis(inputs[1], inputs[2]))
			elseif c.func=="gradientBasis" then
				table.insert(n, k:gradientBasis(inputs[1], inputs[2]))
			elseif c.func=="simplexBasis" then
				table.insert(n, k:simplexBasis(inputs[1]))
			elseif c.func=="combineRGBA" then
				table.insert(n, k:combineRGBA(inputs[1],inputs[2],inputs[3],inputs[4]))
			elseif c.func=="combineHSVA" then
				table.insert(n, k:combineHSVA(inputs[1],inputs[2],inputs[3],inputs[4]))
			else
				if nodetypes.library[c.func] then
					table.insert(n, InstanceFunction(k, nodetypes.library[c.func], inputs))
				elseif nodetypes.user[c.func] then
					table.insert(n, InstanceFunction(k, nodetypes.user[c.func], inputs))
				else
					print("wut")
				end
			end
		end
	end
	print(k:lastIndex())
	return k:lastIndex()
end

function CreateLibraryDesc(n)
	local visited={}
	local recursing={}
	local parameters={}
	local paramnames={}
	local paramtypes={}
	
	local isvisited=function(n)
		local c
		for _,c in ipairs(visited) do
			if c==n then return true end
		end
		return false
	end
	
	local nodeindex=function(n)
		local i,c
		for i,c in ipairs(visited) do
			if c==n then return i end
		end
		return nil
	end
	
	local parameterindex=function(n)
		local i,c
		for i,c in ipairs(parameters) do
			if c==n then return i end
		end
		return nil
	end
	
	local isrecursing=function(n)
		local c
		for _,c in ipairs(recursing) do
			if c==n then return true end
		end
		return false
	end
	
	local st=""
	
	local inst={}
	
	function writenode(n)
		if n.name=="seed" or n.name=="constant" then
			local pi=parameterindex(n)
			if pi then 
				table.insert(inst, {op="Parameter", param=pi})
				st=st.." P"..pi
			else print("Parameter does not exist.")
			end
			return
		elseif n.name=="Output" then
			return
		else
			local thing=
			{
				op="Function",
				func=n.name,
				indices={},
				constants={},
				seeds={},
			}
			
			st=st.." "..n.name
			
			local c
			local inputs=n:GetChild("Inputs",true)
			local numparams=inputs:GetNumChildren()
			for c=1,numparams,1 do
				local src=GetSourceFromNode(n, "Input"..tostring(c-1))
				if src then
					table.insert(thing.indices, nodeindex(src))
					table.insert(thing.constants, "nil")
					table.insert(thing.seeds, "nil")
					st=st.." I"..nodeindex(src)
				else
					local tp=GetNodeTypeDesc(n.name).inputs[c][1] --nodetypes[n.name].inputs[c][1]
					if tp=="value" then
						table.insert(thing.indices, "nil")
						table.insert(thing.constants, tonumber(n:GetChild("Value"..tostring(c-1),true).text))
						table.insert(thing.seeds, "nil")
						st=st.." C"..n:GetChild("Value"..tostring(c-1),true).text
					else
						table.insert(thing.indices, "nil")
						table.insert(thing.seeds, tonumber(n:GetChild("Value"..tostring(c-1),true).text))
						table.insert(thing.constants, "nil")
						st=st.." S"..n:GetChild("Value"..tostring(c-1),true).text
					end
				end
			end
			table.insert(inst, thing)
		end
		
		
	end
	
	local worker
	
	local visitnode=function(n)
		if n.name=="constant" or n.name=="seed" then return true end
		
		local inputs=n:GetChild("Inputs",true)
		local numparams=inputs:GetNumChildren()
		local c
		for c=1,numparams,1 do
			local s=GetSourceFromNode(n, "Input"..tostring(c-1))
			if s and isrecursing(s) then
				print("Cycle detected.")
				return false
			end
			
			if s and not isvisited(s) then
				if s.name=="constant" or s.name=="seed" then
					if s.name=="constant" then
						table.insert(paramtypes, "value")
					else
						table.insert(paramtypes, "seed")
					end
					table.insert(parameters,s)
					table.insert(paramnames, s:GetChild("Title",true).text)
				end
				local ss=worker(s)
				if not ss then return false end
			end
			
		end
		return true
	end
	
	worker=function(n)
		table.insert(recursing,n)
		if not visitnode(n) then
			print("Bailing")
			table.remove(recursing)
			return false
		else
			table.remove(recursing)
			table.insert(visited,n)
			writenode(n)
			return true
		end
	end
	
	if not worker(n) then st=st.."Cycle detected" end
	print("Num params: "..#parameters)
	local nodefunc=
	{
		inputs={},
		instance=inst
	}
	local ct,pm
	for ct,pm in ipairs(parameters) do
		table.insert(nodefunc.inputs, {paramtypes[ct], paramnames[ct], tonumber(pm:GetChild("Value",true).text)})
	end
	return st, nodefunc
end

function GetNodeTypeDesc(type)
	if nodetypes[type] then return nodetypes[type]
	elseif nodetypes.library[type] then return nodetypes.library[type]
	elseif nodetypes.user[type] then return nodetypes.user[type]
	end
	return nil
end

function CreateNodeType(parent, type)
	if type=="seed" then
		local node=ui:LoadLayout(cache:GetResource("XMLFile", "UI/SeedNode.xml"))
		parent:AddChild(node)
		return node
	elseif type=="constant" then
		local node=ui:LoadLayout(cache:GetResource("XMLFIle", "UI/ConstantNode.xml"))
		parent:AddChild(node)
		return node
	end
	
	local d=GetNodeTypeDesc(type)--nodetypes[type]
	if not d then return end
	
	local node=ui:LoadLayout(cache:GetResource("XMLFile", "UI/NodeTemplate.xml"))
	node.name=type
	parent:AddChild(node)
	node:GetChild("Title",true).text=type
	
	local c
	local inputs=node:GetChild("Inputs", true)
	
	for c=1,#d.inputs,1 do
		local input=inputs:CreateChild("UIElement")
		input.name=d.inputs[c][1]
		input:SetLayout(LM_HORIZONTAL)
		local e=input:CreateChild("NodeGraphLinkDest")
		e.name="Input"..(c-1)
		e:SetMinSize(12,12)
		e:SetMaxSize(12,12)
		e:SetImageRect(IntRect(16,0,32,16))
		e.texture=cache:GetResource("Texture2D", "Textures/UI.png")
		
		e=input:CreateChild("LineEdit")
		e.name="Value"..(c-1)
		e:SetStyleAuto(cache:GetResource("XMLFile", "UI/DefaultStyle.xml"))
		e:GetTextElement().fontSize=9
		e:SetText(d.inputs[c][3])
		e:SetMinSize(40,12)
		e:SetMaxSize(40,12)
		
		e=input:CreateChild("Text")
		e:SetStyleAuto(cache:GetResource("XMLFile", "UI/DefaultStyle.xml"))
		e.fontSize=9
		e.text=tostring(d.inputs[c][2])
	end
	return node
	
end

function GetSourceFromNode(node, inputname)
	local c=node:GetChild(inputname,true)
	if c then
		local link=c:GetLink()
		if link then
			local src=link:GetSource()
			if src then
				return src:GetRoot()
			end
		end
	end
	return false
end


function BuildANLFunction(output)
	local nodes={}
	local kernelindices={}
	local isvisited=function(n)
		local c
		for _,c in ipairs(nodes) do
			if c==n then return true end
		end
		return false
	end
	
	local nodeindex=function(n)
		local i,c
		for i,c in ipairs(nodes) do
			if c==n then return i end
		end
		return false
	end
	
	function InstanceANLFunction(kernel, n)
		local GetValue=function(n,which)
			local s=GetSourceFromNode(n,"Input"..which)
			local s1
			if s then s1=kernelindices[nodeindex(s)]
			else local c=tonumber(n:GetChild("Value"..which,true).text) or 1.0 s1=kernel:constant(c) print("Value: "..c) end
			return s1
		end
		
		local GetSeed=function(n,which)
			local s=GetSourceFromNode(n,"Input"..which)
			local s1
			if s then s1=kernelindices[nodeindex(s)]
			else local c=tonumber(n:GetChild("Value"..which,true).text) or 12345 s1=kernel:seed(c) print("Seed: "..c) end
			return s1
		end
		
		local desc=GetNodeTypeDesc(n.name)--nodetypes[n.name]
		if not desc then return end
		local numinputs=#desc.inputs
		local c
		local params={}
		for c=1,numinputs,1 do
			if desc.inputs[c][1]=="value" then
				table.insert(params, GetValue(n,c-1))
			else 
				table.insert(params, GetSeed(n,c-1))
			end
		end

		
		if n.name=="Output" then
			local s1
			local s1=GetValue(n,0)
			return s1
		elseif n.name=="constant" then
			local v=tonumber(n:GetChild("Value", true).text)
			return kernel:constant(v)
		elseif n.name=="seed" then
			local v=tonumber(n:GetChild("Value", true).text)
			return kernel:seed(v)
		else
			print("Instance function "..n.name)
			return InstanceFunction(kernel, desc, params)
		end
		
	end
	
	local kernel=CKernel()
	
	
	
	worker=function(n)
		local visitnode=function(n,numparms)
			local s,c
			for c=0,numparms-1,1 do
				s=GetSourceFromNode(n,"Input"..c)
				if s and not isvisited(s) then worker(s) end
			end
		end
		
		if n.name~="Output" then
			local desc=GetNodeTypeDesc(n.name)--nodetypes[n.name]
			if not desc then print(n.name.." Doesn't exist") return false end
		
			local numinputs=#desc.inputs
			if numinputs>0 then
				visitnode(n, numinputs)
			end
		else
			visitnode(n,1)
		end
		
		table.insert(nodes,n)
		local ind=InstanceANLFunction(kernel, n)
		table.insert(kernelindices, ind)
	end
	print("Packing node graph.")
	
	worker(output)
	local c
	for _,c in ipairs(nodes) do print(c.name) end
	return kernel
end