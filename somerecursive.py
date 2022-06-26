def numinstep(num, step):
    if step == 1:
        return num
    else:
        return num * numinstep(num, step-1)

result = numinstep(5, 55)
print(result)

def countdown(num):
    print(num)
    return countdown(num-1)

try:
    print(countdown(5))
except RecursionError as err:
    print('ok')