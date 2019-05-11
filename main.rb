#Hash Cracker
#Crack hashes, probably very inefficient.
#Copes with various types of hashing
#Auto detects hash type and tries to crack that.
#
#Possible later functionality for brute force attacks etc. but for now just dictionary (list of 100 most common passwords).
#
##rw
#26/03/2019

#require_relative 'bruteAtk.rb' #unfinished
require_relative 'dictionaryAtk.rb' #wip

puts"hashCracker v0(dev)"

#################################################################################################
=begin
#get desired attack mode from user
validInput=false
until validInput==true
	#attack mode options
	puts"Would you like to use a dictionary, or brute force?"
	puts"1 - Dictionary"
	puts"2 - Brute Force"
	input=gets.chomp
	
	#valdation for attack modes
	if input=="1"||input=="2"
		#choice is valid, continue
		validInput=true
	else
		#choice was invalid
		puts""
		puts"You have entered an invalid choice, please try again."
		puts""
	end
end

case input
when "1"
	#Use Dictionary attack.
	
	attackType="dictionary"
when "2"
	#Use Brute Force attack.
	puts"This functionality has not yet been added, please try again later."
	puts"The program will close automatically in 10 seconds."
	sleep(10)
	exit
	
	#attackType="bruteForce"
else
	#Should never be reached, ever.
	puts"Something has gone very wrong, please exit and try again."
	puts"The program will close automatically in 10 seconds."
	sleep(10)
	exit
	#Program should close now
end
=end
attackType="dictionary" #this line needs to be removed when the brute force mode is added
puts"Only the Dictionary mode is available."
puts"It has been automatically selected."
puts""
##################################################################################################


#ask user for file containing the hashes.
#we will assume the hashes are all created using the same function.
#if it isn't, the computer will probably crash. or run for infinity...
#program should detect mismatching hashes and stop before this.
printf"\nPlease enter the *full* filepath of the hashes you would like to be cracked.\n"
printf"Hashes should be of the same type. If they aren't, program will not be able to crack them all and will stop.\n\n"
hashFilepath=gets.chomp

#read the file into the array of hashes
hashes=Array.new
i=0
File.open(hashFilepath).each do |line|
	hashes[i]=line.chomp
	i+=1
end

#hash algorithm checking and mismatch detection
if hashes[0].length == 32
	#hash algorithm is MD5
	hashType="MD5"
elsif hashes[0].length == 40
	#hash algorithm is SHA1
	hashType="SHA1"
elsif hashes[0].length == 64
	#hash algorithm is SHA265
	hashType="SHA256"
elsif hashes[0].length == 128
	#hash algorithm is SHA512
	hashType="SHA512"
else
	#unsupported hash algorithm, close program
	print"[ERROR] Unsupported hashing algorithm! Closing"
	sleep(0.5)
	print"."
	sleep(0.5)
	print"."
	sleep(0.5)
	print".\n"
	puts"Goodbye!"
	exit
end

#hash mismatch detection
for i in 0...hashes.size
	if hashes[0].length==hashes[i].length
		#hashes are made with the same algorithm, continue
	else
		#hashes are not of the same algorithm, exit.
		print"[ERROR] Hash algorithm mismatch detected! Closing"
		sleep(0.5)
		print"."
		sleep(0.5)
		print"."
		sleep(0.5)
		print".\n"
		puts"Goodbye!"
		exit
	end
end

#print the hashing algorithm that was detected
print"Hashing Algorithm Detected:\t#{hashType}\n"
		
#print list of hashes the program now has and will attempt to crack
printf"The hashes the program will attempt to crack are:\n"
no=1
for i in 0...hashes.size
	printf"#{no}\t|\t#{hashes[i]}\n"
	no+=1
end


#array to store passwords once they have been cracked and passed back
crackedHashes=Array.new

#now call function to crack hashes
case attackType

when "bruteForce"
	#call brute forcing function
	puts"This functionality has not yet been added, please try again later."
	puts"The program will close automatically in 10 seconds."
	sleep(10)
	exit
	#passwords=bruteAtk(hashes, hashType)

when "dictionary"
	#call dictionary cracking function
	crackedHashes=dictionaryAtk(hashes, hashType)
else
	#Should never be reached, ever.
	puts"Something has gone very wrong, please exit and try again."
	puts"The program will close automatically in 10 seconds."
	sleep(10)
	exit
	#Program should close now
end

#print out passwords and hashes together
#print table heading

#print underscores for separation
print"Hash"
for i in 0..15 #enough tabs to create the space for SHA512 hashes and an extra tab.
	printf"\t"
end
printf"| Password"
printf"\n"
for i in 0..(133+10) #128 + 5 (+10 for password room (temp))to allow room for SHA512 hashes AND an extra tab for spacing.
	printf"_"
end
printf"\n"

#for ever password we have cracked, print the hash and then password to the output

##probably need a case with a different loop for printing with different number of tabs depending on the length of the hashes
##WIP
File.write("results.txt","Password\tHash\n",mode:'w')
for i in 0...crackedHashes.size
	printf"#{crackedHashes[i][0]}\t#{crackedHashes[i][1]}\n"
	File.write("results.txt","#{crackedHashes[i][1]}\t\t#{crackedHashes[i][0]}\n", mode:'a')
end


print"\n\nEND"
sleep(20)
exit
=begin
FORMAT:
Hash					enough tabs for 512 hashes, 128 spaces (this isnt)				| Password
__________________________________________________________________________________________________
whatever the hash of qwerty is															| qwerty
etc.																					| 
etc.																					| 
etc.																					| 
etc.																					| 
etc.																					| 
etc.																					| 
etc.																					| 

number of tabs in table will need to be changed depending on which hashing algorithm is being used
to maintain formatting and make it neat and with not too much extra space between columns
=end











