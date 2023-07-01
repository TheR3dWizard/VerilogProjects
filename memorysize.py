x = 10**6
n = 0;
print(x)
while True:
    x //= 8;
    if x < 8:
        break;
    n += 1;
print(n,x)

print((2**20)-1>(10**6))
