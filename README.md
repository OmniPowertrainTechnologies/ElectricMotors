# ElectricMotors
A quick summary of different types electric motors that are being used in the industry and their controls


## The follwing image is taken from Nydec and their BLDC application areas for EV - ##
![BLDC Application](/Images/nydec_bldc_application.png)

## Different types of electric motors and their controls - ##

![Different_types_motors](/Images/Emotors.png)

The electric motor controls are given below - 
![Electric_motor_controls](/Images/emotor_controls.png)

Field Oriented Control or (FOC) is widely used and most common type of control for PMSM motors - 

![FOC_bd](/Images/focbd.png)
![FOC](/Images/ClarkePark_Animation.gif)

## Different types of encoders and difference with resolver. 

# Encoder types 
[source](https://www.arrow.com/en/research-and-events/articles/how-to-understand-the-different-types-of-encoders)
- **Tachometer**: These are the most basic type of encoder. Tachometers indicate how far the device has turned but doesn’t track direction. These encoders use on/off signals to indicate that the shaft has turned a certain angle. In the real world, you can best recognize a tachometer in its application in a bike speedometer.

- **Incremental (quadrature)**: Like a tachometer, incremental encoders pulse out signals as a wheel turns a certain angular distance. Unlike a tachometer, it outputs two separate signals in a quadrature arrangement so that it can imply both the distance and direction a shaft turns.

- **Incremental with Extras**: In addition to telling the direction and distance of rotation, some incremental encoders also feature an indexing feature at one point in the rotation. The indexing feature allows the shaft to come back to a known point. Other encoders have a button input, adding a new user interface.

- **Absolute Encoder**: For the most part, incremental encoders don’t inherently “know” a shaft position (except an index point). Absolute encoders use internal sensing to measure the angular position directly and maintain this measurement ability even if the power to it is turned off.

- **Absolute Encoder Multi-Turn**: In addition to knowing the shaft position, multi-turn absolute encoders can also determine how many turns an encoder has made in one direction or the other.
