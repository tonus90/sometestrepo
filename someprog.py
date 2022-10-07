firs_list = [1,2,3,4,5,6]
second_list = [6,5,4,3,2,1]

my_dict = {key:value for key, value in zip(firs_list, second_list)}

print(my_dict)