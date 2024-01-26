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
    #Manual input checkpoint id and UID
    count = 0
    while (True):
        print('Enter your checkpoint:')
        x = input()
        print('Checkpoint: ' + x)
        url = 'https://fsktm-iot-tracker.000webhostapp.com/arduino/addRfidCheckpointHistory.php'
        myobj = {'rfidUID': "A9 73 40 59", 'checkpointID': x}

        x = requests.post(url, data = myobj)

        print(x.text)
        print(count)
        count += 1
        