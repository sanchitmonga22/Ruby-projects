# factorial(n) is defined as n*n-1*n-2..1 for n > 0
# factorial(n) is 1 for n=0
# Let's raise an exception if factorial is negative
# Let's raise an exception if factorial is anything but an integer

def factorial(n)
  # Write the factorial code here per the activity
  fact=1
  if n<0
    throw RuntimeError
  end
  while n>1
    fact=fact*n
    n-=1
  end
  return fact
end
