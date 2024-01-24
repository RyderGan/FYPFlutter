import requests
import serial

def readserial(rfidCheckpointID, comport, baudrate):
    counter = 0
    ser = serial.Serial(comport, baudrate, timeout=0.1)         # 1/timeout is the frequency at which the port is read

    while True:
        data = ser.readline().decode().strip()
        if data:
            value = str(data).strip(" ")
            if (value == "Start"):
                print("Start Arduino Checkpoint")
            else:
                counter += 1 
                print(rfidCheckpointID)
                print(value)

                url = 'https://fsktm-iot-tracker.000webhostapp.com/arduino/addRfidCheckpointHistory.php'
                myobj = {'rfidUID': value, 'checkpointID': rfidCheckpointID}

                x = requests.post(url, data = myobj)

                print(x.text)

if __name__ == '__main__':
    # rfid_module1 = '/dev/cu.usbmodem11201'
    # rfid_module2 = '/dev/cu.usbmodem11301'
    # readserial(2, rfid_module2, 9600)
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
        