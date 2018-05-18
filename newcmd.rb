var = []
INVALID_SYNTAX = "コマンドの文法が誤っています。"
system("")
puts $?

class KTerminal
	@current = __dir__
	class << self
		def echo *o
			o.each {|e| puts e}
		end
		
		def set s,p
			var[s.to_s] = p.to_s
		end
	
		def ev(w)
			return eval(w)
		end
	
	
		def mainloop
			while true
				print @current + ">"
				a = STDIN.gets
				echo tval(a)
			end
		end
		
		def path
			ENV["path"]
		end
		
		def tval p
			s = p.to_s
			spt = []
			spt = s.split(";")
			spt.each {|d|
				d.delete!("\n")
				tval0 d
			}
		end
		
		def tval0 p,*q
			begin
				c = eval("KTerminal::" + p + " " + q.join(","))
				puts c if c != nil
			rescue SyntaxError => e
				puts INVAILD_SYNTAX
			rescue => e
				puts $!
				puts e.inspect
			end
		end
		
		def exit
			Kernel.exit(0)
		end
		
		def cd k
			@current = k
		end
		
		def help
			puts self.instance_methods(false)
		end
		
	end
end

KTerminal::mainloop