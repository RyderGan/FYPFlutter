import requests
import serial

def readserial(rfidCheckpointID, comport, baudrate):
    counter = 0
    ser = serial.Serial(comport, baudrate, timeout=0.1)         # 1/timeout is the frequency at which the port is read

    while True:
        data = ser.readline().decode().strip() #Read Serial Output from Arduino Board
        if data:
            value = str(data).strip(" ")
            if (value == "Start"): #Start Message from Checkpoint
                print("Start Arduino Checkpoint")
            else:
                counter += 1 
                print(rfidCheckpointID)
                print(value)

                #Create Post Request to call checkpoint algorithm
                url = 'https://fsktm-iot-tracker.000webhostapp.com/arduino/addRfidCheckpointHistory.php'
                myobj = {'rfidUID': value, 'checkpointID': rfidCheckpointID}

                x = requests.post(url, data = myobj)
                #Print Response
                print(x.text)

if __name__ == '__main__':
    rfid_module1 = '/dev/cu.usbmodem11201'
    rfid_module2 = '/dev/cu.usbmodem11301'
    readserial(1, rfid_module1, 9600)

