--level manager
level=false

--menu manager
selection=0

--players and balls variables
xspeed=2 yspeed=2
x=64  y=64 yaxis=false
xp1=64 yp1=110  pspeed=4
xp2=64 yp2=16
p1pts=0   p2pts=0

--cpu manager
cpu=false

music_playing=false


function _draw()

	--draw intro screen
	if(not level) then
		cls(0)
		sspr(0,11,120,120,35,35)
		print("2 players",54,84)
		print("1 player",54,94)
	
		if(selection==0) spr(7,44,83)
		if(selection==1) spr(7,44,93)
		
	end

	if(level) then
		cls(11)
		
		--draw tennis court
		line(15,0,15,128,15)
		line(113,0,113,128,15)
		rect(0,0,127,127,15)
		rect(15,20,113,103)
		line(64,20,64,103)
		line(64,0,64,3)
		line(64,128,64,124)
		
		line(1,64,126,64,2)
		
		--draw ball and players
		
			--ball
		if(y>=54 and y<=74) then 
			circfill(x,y,3,10)
		--	spr(9,x,y)
		end
		if((y<54 and y>=44) or(y>74 and y<=84)) then 
			circfill(x,y,2,10)
		end
		if(y<44 or y>84) then
		 circfill(x,y,1,10)
		end
		
			--players
		spr(2,xp1,yp1)
		if(btnp(5,0)) then
	 	spr(5,xp1,yp1)
	 end
	 spr(4,xp2,yp2)
	 
	 --draw score
	 rect(0,0,58,7,1)
	 rectfill(0,0,57,6,6)
	 print ("p1 :"..p1pts.." | p2 : "..p2pts,1,1,1)
	 
	 
	 --draw final screen
	 if(p1pts==5) then
			cls(0)
			print("p1 win",44,44,15)
			print(p1pts.." to "..p2pts,44,54,15)
			print("press x to restart",24,74,15) 
		end
		if(p2pts==5) then
			cls(0)
			print("p2 win",44,44,15)
			print(p1pts.." to "..p2pts,44,54,15)
			print("press x to restart",24,74,15)
		end
 end

end


function _update()
	
	--intro screen
	if(not level) then
		music_start()
 	if(btnp(5)) then
 	 if(selection==0) then
 	 	level=true
 	 end
 	 if(selection==1) then
 	 	level=true
 	 	cpu=true
 	 end
 	end
 	
		if(selection<1 and btnp(3)) then
			selection+=1
		end
		if(selection>0 and btnp(2)) then
			selection-=1
		end
		
	end
	
	if(level) then
	
		music_stop()
		
		--players control
		if(btn(0,0) and xp1>1) then 
			xp1-=pspeed
		end
		if(btn(1,0) and xp1<119) then 
			xp1+=pspeed
		end
		
		if(not cpu) then
			if(btn(0,1) and xp2>1) then 
				xp2-=pspeed
			end
			if(btn(1,1) and xp2<119) then 
				xp2+=pspeed
			end
		end
		
		--cpu control
		if(cpu) then
			if(y<74) then
				if(xp2<x) xp2+=pspeed
				if(xp2>x) xp2-=pspeed
				if((x>xp2 and x<xp2+8)) xp2+=0
			end
		end
		
		--ball physic
		x+=xspeed
		
		if(yaxis) y+=yspeed
		
		if(x>127) then
			xspeed=-xspeed
			yaxis=true
			sfx(0)
		end
		if(y<0) then
			yspeed=-yspeed
			sfx(0)
		end
		if(y>127) then
			yspeed=-yspeed
			sfx(0)
		end
		if(x<0) then
			xspeed=-xspeed
			yaxis=true
			sfx(0)
		end
	
	
		--players collision
		if((x>=xp1 and x<=xp1+8) 
			and y==yp1)
				then
					yspeed=-yspeed
					sfx(0)
		end
		
		if((x>=xp2 and x<=xp2+8) and y==yp2) 
				then
					yspeed=-yspeed
					sfx(0)
		end
	
	
		--points
		if(y<=0) then
			p1pts+=1
			sfx(1)
			y=64
			x=64
			yaxis=false
		end
		
		if(y>=127) then
			p2pts+=1
			sfx(1)
			y=64
			x=64
			yaxis=false
		end
				
		--winning conditions
		if(p1pts==5) then
			xspeed=0
			yspeed=0
			if(btnp(5)) then
				level=false
				p1pts=0
				p2pts=0
				xspeed=2 
				yspeed=2
				xp2=64
			end
		end
		
		if(p2pts==5) then
			xspeed=0
			yspeed=0
			if(btnp(5)) then
				level=false
				p1pts=0
				p2pts=0
				xspeed=2 
				yspeed=2
				xp2=64
			end
		end
	end		
end


--music functions
function music_start()
	if(not music_playing) then
		music_playing=true
		sfx(2)
	end
end

function music_stop()
	if(music_playing) then
		music_playing=false
		music(-1)
	end
end
