--	#################################################
--	# Title:		exitGame.lua					#
--	# Author:		Andres Mrad (Q-ro)				#
--	# Date:			Dec 29 2017						#
--	# Description:	Exit game confirmation menu		#
--	#################################################


local lg = love.graphics

exitGame={}

function exitGame.enter()
	love.event.quit()
end
