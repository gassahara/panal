class veh():
    def __init__(self):
        self.gas="si"
        self.puestos=2
        self.cauchos=4
        self.enmarcha=False
        self.condicion="usado"
    def arranque(self, muevete):
        self.enmarcha=muevete
        if(self.enmarcha==False):
            return "0"
        else:
            return "1"
class carro(veh):
    def __init__(self):
        self.color="Blanco"
        self.largochasis=300
        self.anchoChasis=200
carro1=carro()
print(carro1.arranque(True))
    
        
