#Hash Cracker - Dictionary Attack
#Crack hashes, probably very inefficient.
#Copes with various types of hashing.
#
#Dictionary attack module. WIP
#
##rw
#02/04/2019

require 'digest'

def dictionaryAtk(hashes, hashType)
	crackedHashes=Array.new(1) {Array.new(2)} #=> [[nil, nil], [nil, nil]...] (set up for)
	#to be formatted such that crackedHashes[x][0] will return the hash
	#and that crackedHashes[x][1] will return the password that hash is made from.
	
	dictionary=Array.new
	#read in the dictionary from file
	i=0
	File.open("dictionary.txt").each do |line|
		dictionary[i]=line.chomp
		i+=1
	end
	
	#set up function for hashing
	case hashType
		
	when "MD5"
		hashAlg=Digest::MD5.new
	when "SHA1"
		hashAlg=Digest::SHA1.new
	when "SHA256"
		hashAlg=Digest::SHA256.new
	when "SHA512"
		hashAlg=Digest::SHA512.new
	else
		#Should never be reached, ever.
		puts"[ERROR] Something has gone very wrong, please exit and try again."
		puts"The program will close automatically in 10 seconds."
		sleep(10)
		exit
		#Program should close now
	end
	
	#figure out how many hashes we have to crack
	noHashes=hashes.size
	
	#run through each password in our dictionary
	allCracked=false
	i=0
	until allCracked==true||i==dictionary.size
	#for i in 0...dictionary.size
		#hash the password in the dictionary with the correct algorithm.
		currentHash=hashAlg.hexdigest dictionary[i]
		
		#print the hash we are currently working with
		puts""
		puts"Now checking:"
		printf"#{dictionary[i]}\t#{currentHash}\n"
		
		#compare every password hash we have to crack against this and keep track of any matches
		for j in 0...hashes.size
			printf"Comparing hash no.#{j}:\t#{hashes[j]}:\t"
			if currentHash==hashes[j]
				#store the hash to be output later when the program is finished.
				crackedHashes.push([hashes[j], dictionary[i]])
				printf"MATCH\n"
			else
				#no match, next entry.
				printf"NO MATCH\n"
			end
		end
		if hashes.size==(crackedHashes.size-1)
			allCracked=true
		end
		i+=1
	end
	
	#remove first entry containing the nil from setup
	crackedHashes.shift
	
	return crackedHashes
	
	#order of operations:
	#for each password we have in the dictionary:
		#hash the password, and run through array of hashes we've been given.
		#compare hashes, if the same, password cracked, set it aside, and continue to compare the rest
		#once all have been compared, next password in dictionary
		


	
	#to hash:
	#hash=hashAlg.hexdigest password
end

