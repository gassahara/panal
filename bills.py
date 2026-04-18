def separate_pellets(num_pellets):
    boxes = [1000000, 500000.0, 250000.0, 200000.0, 125000.0, 100000, 50000.0, 25000.0, 20000.0, 12500.0, 10000, 5000.0, 2500.0, 2000.0, 1250.0, 1000, 500.0, 250.0, 200.0, 125.0, 100, 50.0, 25.0, 20.0, 10, 5, 2, 1]
    boxes.sort()
    result = []
    for box in boxes:
        i=0
        print("BOX: ", box, num_pellets)
        while num_pellets > 0 and num_pellets >= box and i < 10:
            result.append(box)
            print(num_pellets)
            num_pellets -= box
            i+=1
    boxes.sort(reverse=True)
    while num_pellets > 0:
        for box in boxes:
            print("BOX: ", box, num_pellets)
            while num_pellets > 0 and num_pellets >= box:
                result.append(box)
                print(num_pellets)
                num_pellets -= box
    sum = 0
    for i in result:
        sum += i
    print("sum:", sum, len(result), boxes)
    return result
print(separate_pellets(100*(10**6)))
