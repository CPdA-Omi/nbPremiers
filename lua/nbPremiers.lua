prime=true
cpt=0
cptLine=0
nbPerLine=10
min=arg[1]
max=arg[2]
totalArgs=#arg
basicPrimeNumbers={1,2,3,5,7}

if totalArgs ~= 1 and totalArgs ~= 2 then -- unvalid arguments number
	print("Error: give ONE or TWO arguments")
	return 1

-- elseif min < 1 then -- unvalid numbers (no good matches)
--	print("Error: unvalid number")
--	return 1

elseif totalArgs == 1 then -- only one number
	if min == 1 or min == 2 or min == 3 then
		print(min, " is a prime number")
		return 0
	else
		if min%2 ~= 0 then
			prime=true
			for i=3, min^0.5, 2 do
				if min%i == 0 then
					prime=false
					break
				end
			end
			if prime == true then
				print(min, " is a prime number")
				return 0
			end
		end
	end
	print(min, " is NOT a prime number")
	return 0
end

if min > max then -- inversion
	alt=min
	min=max
	max=alt
	print("Numbers swapped!")
end

--if min == 1 and max > 2 then
--	min=min+1
--end

print("Prime numbers between ", min, "and", max, "\n")

for i=min, max, 1 do -- multiple valid numbers (flush on all numbers between min and max)
	if i==1 or i == 2 or i == 3 or i == 5 then
		io.write("\t", i)
		cpt=cpt+1
		cptLine=cptLine+1
		goto continue
	else
		if i%2 ~= 0 and i%5 ~=0 then -- is not even or not a multiple of 5
			prime=true
			if cptLine > nbPerLine-1 then
				print("")
				cptLine=0
			end
			for j=3, i^0.5+1, 2 do -- flush on all potential divisor between 3 and sqrt(i)+1
				if i%j == 0 then
					prime=false
					break
				end
			end
			if prime == true then
				io.write("\t", i)
				cpt=cpt+1
				cptLine=cptLine+1
			end
		end
	end
	::continue::
end

print("\n\nPrime numbers : ", cpt)
