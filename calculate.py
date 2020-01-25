import math

fr = float(input("Enter the resonant Frequency in GHz"))
er = float(input("Enter the dielectric const."))
hs = float(input("Enter the height of substrate in cm"))
#hc = int(input("Enter the height of copper"))

print("Calculating Dimensions for antenna with frequency"+ str(fr))

fr = fr*math.pow(10,9)
print("Calculating F")
f = (8.791*math.pow(10,9))/(fr*math.sqrt(er))
print("Value of F is" + str(f))

d = (math.pi*f)/(2*hs)

print("Calculating Radius")
r= f/math.sqrt((1+((1/(d*er))*(math.log(d)+1.7726))))
r=r*10

print("Radius of Patch in mm is "+ str(r))
