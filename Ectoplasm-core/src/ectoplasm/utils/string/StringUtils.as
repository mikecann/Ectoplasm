package ectoplasm.utils.string
{
	import flash.geom.Rectangle;
	
	import ectoplasm.utils.geom.Pt;
	import ectoplasm.utils.math.NumberUtils;

	public class StringUtils
	{		
		/**
		 * Takes a delimiter sepparated list of ints and returns a vector of ints.
		 * For example 3,6,45 would return new <int>[3,6,45]
		 */
		static public function splitInts(str:String,delimiter:String=",") : Vector.<int>
		{
			var data : Vector.<int> = new Vector.<int>();
			var split : Array = str.split(delimiter);
			for each (var s : String in split){ s!=''?data.push(int(s)):0; }
			return data;
		}
		
		/**
		 * Takes a delimiter sepparated list of strings and returns a vector of strings
		 */
		static public function splitStrings(str:String,delimiter:String=",") : Vector.<String>
		{
			var data : Vector.<String> = new Vector.<String>();
			var split : Array = str.split(delimiter);
			for each (var s : String in split){ s!=''?data.push(s):0; }
			return data;
		}
		
		/**
		 * Remove bracketed content (like this) from a string
		 */
		static public function removeBrackets(text:String) : String
		{
			return text.replace(/\s*\([^)]*\)/, '');
		}
		
		/**
		 * Takes a delimiter sepparated list of numbers and returns a vector of Numbers. 
		 * For example 3.35,6.474,45.34 would return new <Number>[3.35,6.474,45.34]
		 */
		static public function splitNumbers(str:String,delimiter:String=",") : Vector.<Number>
		{
			var data : Vector.<Number> = new Vector.<Number>();
			var split : Array = str.split(delimiter);
			for each (var s : String in split){ s!=''?data.push(Number(s)):0; }
			return data;
		}
		
		/**
		 * Takes a delimiter sepparated list of ints and returns a vector of Booleans. 
		 * For example 1,1,0,1 would truen true,true,false,true
		 */
		static public function splitBooleans(str:String,delimiter:String=",") : Vector.<Boolean>
		{
			var data : Vector.<Boolean> = new Vector.<Boolean>();
			var split : Array = str.split(delimiter);		
			for each (var s : String in split){ s!=''?data.push(int(s)):0; }
			return data;
		}
		
		/**
		 * Takes a delimiter sepparated list of ints and returns a dimension. 
		 * For example 34,123 would return new Rectangle(0,0,34,123)
		 */
		static public function getDimensions(str:String,delimiter:String=",") : Rectangle
		{
			if(!str || str==""){ return new Rectangle(0,0,1,1); }
			var a : Array = str.split(',');
			if(a.length<2){ return new Rectangle(0,0,1,1); }
			return new Rectangle(0,0,int(a[0]),int(a[1]));
		}
		
		/**
		 * Takes a delimiter sepparated list of ints and returns a coordinate. 
		 * For example 22,456 would return new Pt(22,456)
		 */
		static public function getCoordinate(str:String,delimiter:String=",") : Pt
		{
			if(!str || str==""){ return new Pt(0,0); }
			var a : Array = str.split(',');
			if(a.length == 2) { return new Pt(int(a[0]),int(a[1])); }
			if(a.length == 3) { return new Pt(int(a[0]), int(a[1]), int(a[2])); }
			return new Pt(0,0);
		}
		
		static public function removeNewLines(str:String) : String
		{
			str = str.split('\n').join();
			str = str.split('\r').join();
			return str;
		}
		
		static public function stripAllWhitespace(str:String) : String
		{
			str = str.split('\n').join();
			str = str.split('\r').join();
			str = str.split('\t').join();
			return str;
		}
		
		public static function removeIllegalIdentifierCharachters(inpStr:String) : String
		{
			//var regexp : RegExp = /[^a-zA-Z0-9/-]+;
			inpStr.replace("[^a-zA-Z0-9/-]+","");
			return inpStr;
		}

		public static function truncate(str:String, maxLen:int):String
		{
			var outS : String = str.substr(0,maxLen-1);
			var diff : int = str.length-outS.length;
			for(var i:int=0;i<diff&&i<3; i++){ outS+="."; }
			return outS;
		}
		
		public static function get24HFormattedTime(timeSecs:int) : String
		{
			var h : int = timeSecs/60;
			var m : int = timeSecs-(h*60);
			return NumberUtils.ensureLeadingZeros(h,2)+":"+NumberUtils.ensureLeadingZeros(m,2);				
		}

		public static function getTaskTimeRemaining(timeSecs:int) : String
		{
			var days:int = Math.floor(timeSecs/216000);
			timeSecs -= days * 216000;
			var hours:int = Math.floor(timeSecs/3600);
			timeSecs -= hours * 3600;
			var mins:int = Math.floor(timeSecs/60);
			timeSecs -= mins * 60;
			var secs:int = timeSecs;
			
			var time:String;
			
			if(days > 0)
				time = days + "d " + hours + "h " + mins + "m ";
			else if(hours > 0)
				time = hours + "h " + mins + "m " + secs + "s";
			else if(mins > 0)
				time = mins + "m " + secs + "s";
			else
				time = secs + "s";
			
			return time;
		}
		
		public static function fromCamelToScreamingSnakeCase(str:String) : String
		{
			if(isNullOrEmpty(str)) return null;
			var outStr : String = str.charAt(0).toUpperCase();
			var lastChar : int = str.charCodeAt(0);
			for(var i :int = 1; i<str.length; i++)
			{
				var thisChar : int = str.charCodeAt(i);
				if(thisChar>64 && thisChar<91 && lastChar>96 && lastChar<123) outStr += "_"+str.charAt(i).toUpperCase();
				else outStr += str.charAt(i).toUpperCase();
				lastChar = thisChar;
			}
			return outStr;
		}
		
		public static function formatFromObject(inputStr:String, obj:Object) : String
		{
			var outStr : String = inputStr;
			for (var key : String in obj) outStr = outStr.split("{"+key+"}").join(obj[key]);
			return outStr;
		}
		
		public static function isNullOrEmpty(str:String) : Boolean
		{
			return str==null || str=="";
		}
		
		public static function getValidConstantIdentifierName(str:String) : String
		{
			var s : String = str.split(" ").join("_");
			s = s.replace(/[^a-zA-Z_0-9\/-]+/g,"");
			while(s.length>0)
			{				
				if(!isNaN(Number(s.charAt(0))))
				{
					if(s.length==1) return "";
					else { s = s.substring(1); }
				}
				else break;			
			}
			return s.toUpperCase();			
		}
		
		public static const DAYS:Array = ['Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday'];
		public static const MONTHS:Array = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
		public static const ORDINALS:Array = ['th','st','nd','rd','th','th','th','th','th','th'];
		
		public static function getDateFromUTCMilliseconds(utcTimeMs:Number) : String
		{
			var d:Date = new Date(utcTimeMs);
			var ord:int = int(String(d.date).charAt(String(d.date).length-1));
			return DAYS[d.day]+' '+MONTHS[d.month]+' '+d.date+ORDINALS[ord]+' '+d.fullYearUTC;
		}
		
		public static function getTimeFromUTCMilliseconds(utcTimeMs:Number, includeMs:Boolean = false) : String
		{
			var d:Date = new Date(utcTimeMs);
			var s:String =
				NumberUtils.ensureLeadingZeros(d.hours,2)+':'+
				NumberUtils.ensureLeadingZeros(d.minutes,2)+':'+
				NumberUtils.ensureLeadingZeros(d.seconds,2);
			if (includeMs) s += '.'+NumberUtils.ensureLeadingZeros(d.milliseconds,3);
			return s;
		}
		
		/**
		 * Formats a number with seperators for thousands.
		 * Taken from: http://flassari.is/2009/08/number-format-thousand-separator-in-as3/
		 */
		public static function formatNumberInThousands(number:*, maxDecimals:int = 2, forceDecimals:Boolean = false, siStyle:Boolean = true):String {
			var i:int = 0, inc:Number = Math.pow(10, maxDecimals), str:String = String(Math.round(inc * Number(number))/inc);
			var hasSep:Boolean = str.indexOf(".") == -1, sep:int = hasSep ? str.length : str.indexOf(".");
			var ret:String = (hasSep && !forceDecimals ? "" : (siStyle ? "," : ".")) + str.substr(sep+1);
			if (forceDecimals)for (var j:int = 0; j <= maxDecimals - (str.length - (hasSep ? sep-1 : sep)); j++) ret += "0";
			while (i + 3 < (str.substr(0, 1) == "-" ? sep-1 : sep)) ret = (siStyle ? "." : ",") + str.substr(sep - (i += 3), 3) + ret;
			return str.substr(0, sep - i) + ret;
		}
		
		/**
		 *	Returns everything after the first occurrence of the provided character in the string.
		 *
		 *	@param p_string The string.
		 *
		 *	@param p_begin The character or sub-string.
		 *
		 *	@returns String
		 *
		 * 	@langversion ActionScript 3.0
		 *	@playerversion Flash 9.0
		 *	@tiptext
		 *
		 */
		public static function afterFirst(p_string:String, p_char:String):String {
			if (p_string == null) { return ''; }
			var idx:int = p_string.indexOf(p_char);
			if (idx == -1) { return ''; }
			idx += p_char.length;
			return p_string.substr(idx);
		}
		
		/**
		 *	Returns everything after the last occurence of the provided character in p_string.
		 *
		 *	@param p_string The string.
		 *
		 *	@param p_char The character or sub-string.
		 *
		 *	@returns String
		 *
		 * 	@langversion ActionScript 3.0
		 *	@playerversion Flash 9.0
		 *	@tiptext
		 */
		public static function afterLast(p_string:String, p_char:String):String {
			if (p_string == null) { return ''; }
			var idx:int = p_string.lastIndexOf(p_char);
			if (idx == -1) { return ''; }
			idx += p_char.length;
			return p_string.substr(idx);
		}
		
		/**
		 *	Determines whether the specified string begins with the specified prefix.
		 *
		 *	@param p_string The string that the prefix will be checked against.
		 *
		 *	@param p_begin The prefix that will be tested against the string.
		 *
		 *	@returns Boolean
		 *
		 * 	@langversion ActionScript 3.0
		 *	@playerversion Flash 9.0
		 *	@tiptext
		 */
		public static function beginsWith(p_string:String, p_begin:String):Boolean {
			if (p_string == null) { return false; }
			return p_string.indexOf(p_begin) == 0;
		}
		
		/**
		 *	Returns everything before the first occurrence of the provided character in the string.
		 *
		 *	@param p_string The string.
		 *
		 *	@param p_begin The character or sub-string.
		 *
		 *	@returns String
		 *
		 * 	@langversion ActionScript 3.0
		 *	@playerversion Flash 9.0
		 *	@tiptext
		 */
		public static function beforeFirst(p_string:String, p_char:String):String {
			if (p_string == null) { return ''; }
			var idx:int = p_string.indexOf(p_char);
			if (idx == -1) { return ''; }
			return p_string.substr(0, idx);
		}
		
		/**
		 *	Returns everything before the last occurrence of the provided character in the string.
		 *
		 *	@param p_string The string.
		 *
		 *	@param p_begin The character or sub-string.
		 *
		 *	@returns String
		 *
		 * 	@langversion ActionScript 3.0
		 *	@playerversion Flash 9.0
		 *	@tiptext
		 */
		public static function beforeLast(p_string:String, p_char:String):String {
			if (p_string == null) { return ''; }
			var idx:int = p_string.lastIndexOf(p_char);
			if (idx == -1) { return ''; }
			return p_string.substr(0, idx);
		}
		
		/**
		 *	Returns everything after the first occurance of p_start and before
		 *	the first occurrence of p_end in p_string.
		 *
		 *	@param p_string The string.
		 *
		 *	@param p_start The character or sub-string to use as the start index.
		 *
		 *	@param p_end The character or sub-string to use as the end index.
		 *
		 *	@returns String
		 *
		 * 	@langversion ActionScript 3.0
		 *	@playerversion Flash 9.0
		 *	@tiptext
		 */
		public static function between(p_string:String, p_start:String, p_end:String):String {
			var str:String = '';
			if (p_string == null) { return str; }
			var startIdx:int = p_string.indexOf(p_start);
			if (startIdx != -1) {
				startIdx += p_start.length; // RM: should we support multiple chars? (or ++startIdx);
				var endIdx:int = p_string.indexOf(p_end, startIdx);
				if (endIdx != -1) { str = p_string.substr(startIdx, endIdx-startIdx); }
			}
			return str;
		}
		
		/**
		 *	Description, Utility method that intelligently breaks up your string,
		 *	allowing you to create blocks of readable text.
		 *	This method returns you the closest possible match to the p_delim paramater,
		 *	while keeping the text length within the p_len paramter.
		 *	If a match can't be found in your specified length an  '...' is added to that block,
		 *	and the blocking continues untill all the text is broken apart.
		 *
		 *	@param p_string The string to break up.
		 *
		 *	@param p_len Maximum length of each block of text.
		 *
		 *	@param p_delim delimter to end text blocks on, default = '.'
		 *
		 *	@returns Array
		 *
		 * 	@langversion ActionScript 3.0
		 *	@playerversion Flash 9.0
		 *	@tiptext
		 */
		public static function block(p_string:String, p_len:uint, p_delim:String = "."):Array {
			var arr:Array = new Array();
			if (p_string == null || !contains(p_string, p_delim)) { return arr; }
			var chrIndex:uint = 0;
			var strLen:uint = p_string.length;
			var replPatt:RegExp = new RegExp("[^"+escapePattern(p_delim)+"]+$");
			while (chrIndex <  strLen) {
				var subString:String = p_string.substr(chrIndex, p_len);
				if (!contains(subString, p_delim)){
					arr.push(truncate(subString, subString.length));
					chrIndex += subString.length;
				}
				subString = subString.replace(replPatt, '');
				arr.push(subString);
				chrIndex += subString.length;
			}
			return arr;
		}
		
		/**
		 *	Capitallizes the first word in a string or all words..
		 *
		 *	@param p_string The string.
		 *
		 *	@param p_all (optional) Boolean value indicating if we should
		 *	capitalize all words or only the first.
		 *
		 *	@returns String
		 *
		 * 	@langversion ActionScript 3.0
		 *	@playerversion Flash 9.0
		 *	@tiptext
		 */
		public static function capitalize(p_string:String, ...args):String {
			var str:String = trimLeft(p_string);
			trace('capl', args[0])
			if (args[0] === true) { return str.replace(/^.|\b./g, _upperCase);}
			else { return str.replace(/(^\w)/, _upperCase); }
		}
		
		/**
		 *	Determines whether the specified string contains any instances of p_char.
		 *
		 *	@param p_string The string.
		 *
		 *	@param p_char The character or sub-string we are looking for.
		 *
		 *	@returns Boolean
		 *
		 * 	@langversion ActionScript 3.0
		 *	@playerversion Flash 9.0
		 *	@tiptext
		 */
		public static function contains(p_string:String, p_char:String):Boolean {
			if (p_string == null) { return false; }
			return p_string.indexOf(p_char) != -1;
		}
		
		/**
		 *	Determines the number of times a charactor or sub-string appears within the string.
		 *
		 *	@param p_string The string.
		 *
		 *	@param p_char The character or sub-string to count.
		 *
		 *	@param p_caseSensitive (optional, default is true) A boolean flag to indicate if the
		 *	search is case sensitive.
		 *
		 *	@returns uint
		 *
		 * 	@langversion ActionScript 3.0
		 *	@playerversion Flash 9.0
		 *	@tiptext
		 */
		public static function countOf(p_string:String, p_char:String, p_caseSensitive:Boolean = true):uint {
			if (p_string == null) { return 0; }
			var char:String = escapePattern(p_char);
			var flags:String = (!p_caseSensitive) ? 'ig' : 'g';
			return p_string.match(new RegExp(char, flags)).length;
		}
		
		/**
		 *	Levenshtein distance (editDistance) is a measure of the similarity between two strings,
		 *	The distance is the number of deletions, insertions, or substitutions required to
		 *	transform p_source into p_target.
		 *
		 *	@param p_source The source string.
		 *
		 *	@param p_target The target string.
		 *
		 *	@returns uint
		 *
		 * 	@langversion ActionScript 3.0
		 *	@playerversion Flash 9.0
		 *	@tiptext
		 */
		public static function editDistance(p_source:String, p_target:String):uint {
			var i:uint;
			
			if (p_source == null) { p_source = ''; }
			if (p_target == null) { p_target = ''; }
			
			if (p_source == p_target) { return 0; }
			
			var d:Array = new Array();
			var cost:uint;
			var n:uint = p_source.length;
			var m:uint = p_target.length;
			var j:uint;
			
			if (n == 0) { return m; }
			if (m == 0) { return n; }
			
			for (i=0; i<=n; i++) { d[i] = new Array(); }
			for (i=0; i<=n; i++) { d[i][0] = i; }
			for (j=0; j<=m; j++) { d[0][j] = j; }
			
			for (i=1; i<=n; i++) {
				
				var s_i:String = p_source.charAt(i-1);
				for (j=1; j<=m; j++) {
					
					var t_j:String = p_target.charAt(j-1);
					
					if (s_i == t_j) { cost = 0; }
					else { cost = 1; }
					
					d[i][j] = _minimum(d[i-1][j]+1, d[i][j-1]+1, d[i-1][j-1]+cost);
				}
			}
			return d[n][m];
		}
		
		/**
		 *	Determines whether the specified string ends with the specified suffix.
		 *
		 *	@param p_string The string that the suffic will be checked against.
		 *
		 *	@param p_end The suffix that will be tested against the string.
		 *
		 *	@returns Boolean
		 *
		 * 	@langversion ActionScript 3.0
		 *	@playerversion Flash 9.0
		 *	@tiptext
		 */
		public static function endsWith(p_string:String, p_end:String):Boolean {
			return p_string.lastIndexOf(p_end) == p_string.length - p_end.length;
		}
		
		/**
		 *	Determines whether the specified string contains text.
		 *
		 *	@param p_string The string to check.
		 *
		 *	@returns Boolean
		 *
		 * 	@langversion ActionScript 3.0
		 *	@playerversion Flash 9.0
		 *	@tiptext
		 */
		public static function hasText(p_string:String):Boolean {
			var str:String = removeExtraWhitespace(p_string);
			return !!str.length;
		}
		
		/**
		 *	Determines whether the specified string contains any characters.
		 *
		 *	@param p_string The string to check
		 *
		 *	@returns Boolean
		 *
		 * 	@langversion ActionScript 3.0
		 *	@playerversion Flash 9.0
		 *	@tiptext
		 */
		public static function isEmpty(p_string:String):Boolean {
			if (p_string == null) { return true; }
			return !p_string.length;
		}
		
		/**
		 *	Determines whether the specified string is numeric.
		 *
		 *	@param p_string The string.
		 *
		 *	@returns Boolean
		 *
		 * 	@langversion ActionScript 3.0
		 *	@playerversion Flash 9.0
		 *	@tiptext
		 */
		public static function isNumeric(p_string:String):Boolean {
			if (p_string == null) { return false; }
			var regx:RegExp = /^[-+]?\d*\.?\d+(?:[eE][-+]?\d+)?$/;
			return regx.test(p_string);
		}
		
		/**
		 * Pads p_string with specified character to a specified length from the left.
		 *
		 *	@param p_string String to pad
		 *
		 *	@param p_padChar Character for pad.
		 *
		 *	@param p_length Length to pad to.
		 *
		 *	@returns String
		 *
		 * 	@langversion ActionScript 3.0
		 *	@playerversion Flash 9.0
		 *	@tiptext
		 */
		public static function padLeft(p_string:String, p_padChar:String, p_length:uint):String {
			var s:String = p_string;
			while (s.length < p_length) { s = p_padChar + s; }
			return s;
		}
		
		/**
		 * Pads p_string with specified character to a specified length from the right.
		 *
		 *	@param p_string String to pad
		 *
		 *	@param p_padChar Character for pad.
		 *
		 *	@param p_length Length to pad to.
		 *
		 *	@returns String
		 *
		 * 	@langversion ActionScript 3.0
		 *	@playerversion Flash 9.0
		 *	@tiptext
		 */
		public static function padRight(p_string:String, p_padChar:String, p_length:uint):String {
			var s:String = p_string;
			while (s.length < p_length) { s += p_padChar; }
			return s;
		}
		
		/**
		 *	Properly cases' the string in "sentence format".
		 *
		 *	@param p_string The string to check
		 *
		 *	@returns String.
		 *
		 * 	@langversion ActionScript 3.0
		 *	@playerversion Flash 9.0
		 *	@tiptext
		 */
		public static function properCase(p_string:String):String {
			if (p_string == null) { return ''; }
			var str:String = p_string.toLowerCase().replace(/\b([^.?;!]+)/, capitalize);
			return str.replace(/\b[i]\b/, "I");
		}
		
		/**
		 *	Escapes all of the characters in a string to create a friendly "quotable" sting
		 *
		 *	@param p_string The string that will be checked for instances of remove
		 *	string
		 *
		 *	@returns String
		 *
		 * 	@langversion ActionScript 3.0
		 *	@playerversion Flash 9.0
		 *	@tiptext
		 */
		public static function quote(p_string:String):String {
			var regx:RegExp = /[\\"\r\n]/g;
			return '"'+ p_string.replace(regx, _quote) +'"'; //"
		}
		
		/**
		 *	Removes all instances of the remove string in the input string.
		 *
		 *	@param p_string The string that will be checked for instances of remove
		 *	string
		 *
		 *	@param p_remove The string that will be removed from the input string.
		 *
		 *	@param p_caseSensitive An optional boolean indicating if the replace is case sensitive. Default is true.
		 *
		 *	@returns String
		 *
		 * 	@langversion ActionScript 3.0
		 *	@playerversion Flash 9.0
		 *	@tiptext
		 */
		public static function remove(p_string:String, p_remove:String, p_caseSensitive:Boolean = true):String {
			if (p_string == null) { return ''; }
			var rem:String = escapePattern(p_remove);
			var flags:String = (!p_caseSensitive) ? 'ig' : 'g';
			return p_string.replace(new RegExp(rem, flags), '');
		}
		
		/**
		 *	Removes extraneous whitespace (extra spaces, tabs, line breaks, etc) from the
		 *	specified string.
		 *
		 *	@param p_string The String whose extraneous whitespace will be removed.
		 *
		 *	@returns String
		 *
		 * 	@langversion ActionScript 3.0
		 *	@playerversion Flash 9.0
		 *	@tiptext
		 */
		public static function removeExtraWhitespace(p_string:String):String {
			if (p_string == null) { return ''; }
			var str:String = trim(p_string);
			return str.replace(/\s+/g, ' ');
		}
		
		/**
		 *	Returns the specified string in reverse character order.
		 *
		 *	@param p_string The String that will be reversed.
		 *
		 *	@returns String
		 *
		 * 	@langversion ActionScript 3.0
		 *	@playerversion Flash 9.0
		 *	@tiptext
		 */
		public static function reverse(p_string:String):String {
			if (p_string == null) { return ''; }
			return p_string.split('').reverse().join('');
		}
		
		/**
		 *	Returns the specified string in reverse word order.
		 *
		 *	@param p_string The String that will be reversed.
		 *
		 *	@returns String
		 *
		 * 	@langversion ActionScript 3.0
		 *	@playerversion Flash 9.0
		 *	@tiptext
		 */
		public static function reverseWords(p_string:String):String {
			if (p_string == null) { return ''; }
			return p_string.split(/\s+/).reverse().join('');
		}
		
		/**
		 *	Determines the percentage of similiarity, based on editDistance
		 *
		 *	@param p_source The source string.
		 *
		 *	@param p_target The target string.
		 *
		 *	@returns Number
		 *
		 * 	@langversion ActionScript 3.0
		 *	@playerversion Flash 9.0
		 *	@tiptext
		 */
		public static function similarity(p_source:String, p_target:String):Number {
			var ed:uint = editDistance(p_source, p_target);
			var maxLen:uint = Math.max(p_source.length, p_target.length);
			if (maxLen == 0) { return 100; }
			else { return (1 - ed/maxLen) * 100; }
		}
		
		/**
		 *	Remove's all < and > based tags from a string
		 *
		 *	@param p_string The source string.
		 *
		 *	@returns String
		 *
		 * 	@langversion ActionScript 3.0
		 *	@playerversion Flash 9.0
		 *	@tiptext
		 */
		public static function stripTags(p_string:String):String {
			if (p_string == null) { return ''; }
			return p_string.replace(/<\/?[^>]+>/igm, '');
		}
		
		/**
		 *	Swaps the casing of a string.
		 *
		 *	@param p_string The source string.
		 *
		 *	@returns String
		 *
		 * 	@langversion ActionScript 3.0
		 *	@playerversion Flash 9.0
		 *	@tiptext
		 */
		public static function swapCase(p_string:String):String {
			if (p_string == null) { return ''; }
			return p_string.replace(/(\w)/, _swapCase);
		}
		
		/**
		 *	Removes whitespace from the front and the end of the specified
		 *	string.
		 *
		 *	@param p_string The String whose beginning and ending whitespace will
		 *	will be removed.
		 *
		 *	@returns String
		 *
		 * 	@langversion ActionScript 3.0
		 *	@playerversion Flash 9.0
		 *	@tiptext
		 */
		public static function trim(p_string:String):String {
			if (p_string == null) { return ''; }
			return p_string.replace(/^\s+|\s+$/g, '');
		}
		
		/**
		 *	Removes whitespace from the front (left-side) of the specified string.
		 *
		 *	@param p_string The String whose beginning whitespace will be removed.
		 *
		 *	@returns String
		 *
		 * 	@langversion ActionScript 3.0
		 *	@playerversion Flash 9.0
		 *	@tiptext
		 */
		public static function trimLeft(p_string:String):String {
			if (p_string == null) { return ''; }
			return p_string.replace(/^\s+/, '');
		}
		
		/**
		 *	Removes whitespace from the end (right-side) of the specified string.
		 *
		 *	@param p_string The String whose ending whitespace will be removed.
		 *
		 *	@returns String	.
		 *
		 * 	@langversion ActionScript 3.0
		 *	@playerversion Flash 9.0
		 *	@tiptext
		 */
		public static function trimRight(p_string:String):String {
			if (p_string == null) { return ''; }
			return p_string.replace(/\s+$/, '');
		}
		
		/**
		 *	Determins the number of words in a string.
		 *
		 *	@param p_string The string.
		 *
		 *	@returns uint
		 *
		 * 	@langversion ActionScript 3.0
		 *	@playerversion Flash 9.0
		 *	@tiptext
		 */
		public static function wordCount(p_string:String):uint {
			if (p_string == null) { return 0; }
			return p_string.match(/\b\w+\b/g).length;
		}		
		
		/* **************************************************************** */
		/*	These are helper methods used by some of the above methods.		*/
		/* **************************************************************** */
		private static function escapePattern(p_pattern:String):String {
			// RM: might expose this one, I've used it a few times already.
			return p_pattern.replace(/(\]|\[|\{|\}|\(|\)|\*|\+|\?|\.|\\)/g, '\\$1');
		}
		
		private static function _minimum(a:uint, b:uint, c:uint):uint {
			return Math.min(a, Math.min(b, Math.min(c,a)));
		}
		
		private static function _quote(p_string:String, ...args):String {
			switch (p_string) {
				case "\\":
					return "\\\\";
				case "\r":
					return "\\r";
				case "\n":
					return "\\n";
				case '"':
					return '\\"';
				default:
					return '';
			}
		}
		
		private static function _upperCase(p_char:String, ...args):String {
			trace('cap latter ',p_char)
			return p_char.toUpperCase();
		}
		
		private static function _swapCase(p_char:String, ...args):String {
			var lowChar:String = p_char.toLowerCase();
			var upChar:String = p_char.toUpperCase();
			switch (p_char) {
				case lowChar:
					return upChar;
				case upChar:
					return lowChar;
				default:
					return p_char;
			}
		}	
	}
}