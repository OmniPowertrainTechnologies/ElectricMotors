# ElectricMotors
A quick summary of different types electric motors that are being used in the industry and their controls


## The follwing image is taken from Nydec and their BLDC application areas for EV - ##
![BLDC Application](/Images/nydec_bldc_application.png)

## Different types of electric motors and their controls - ##

![Different_types_motors](/Images/Emotors.png)

The electric motor controls are given below - 
![Electric_motor_controls](/Images/emotor_controls.png)

Field Oriented Control or (FOC) is widely used and most common type of control for PMSM motors - 
<p align="center">
![FOC_bd](/Images/focbd.png)
![FOC](/Images/ClarkePark_Animation.gif)
</p>
## Encoder, Hall Sensors and Resolvers 

### Encoder types 
[source](https://www.arrow.com/en/research-and-events/articles/how-to-understand-the-different-types-of-encoders)
- **Tachometer**: These are the most basic type of encoder. Tachometers indicate how far the device has turned but doesn’t track direction. These encoders use on/off signals to indicate that the shaft has turned a certain angle. In the real world, you can best recognize a tachometer in its application in a bike speedometer.

- **Incremental (quadrature)**: Like a tachometer, incremental encoders pulse out signals as a wheel turns a certain angular distance. Unlike a tachometer, it outputs two separate signals in a quadrature arrangement so that it can imply both the distance and direction a shaft turns.
![quadrature_encoder](/Images/QuadratureAnimation.gif)
    * **3-channel incremental encoder** -The incremental encoder usually provides two types of squared waves, out-of-phase of 90° electrical degrees, which are usually called channel A and B. Channel A   gives information only about the rotation speed (number of pulses in a certain unit of time), while channel B provides data regarding the direction of rotation, according to the sequence produced by the two signals. Another signal, called Z or zero channel, is also available; it gives the absolute “zero” position of the encoder shaft and is used as a reference point. 
<p align="center">
![FOC_bd](/Images/encoder_inc.png) 
</p>
- **Incremental with Extras**: In addition to telling the direction and distance of rotation, some incremental encoders also feature an indexing feature at one point in the rotation. The indexing feature allows the shaft to come back to a known point. Other encoders have a button input, adding a new user interface.

- **Absolute Encoder**: For the most part, incremental encoders don’t inherently “know” a shaft position (except an index point). Absolute encoders use internal sensing to measure the angular position directly and maintain this measurement ability even if the power to it is turned off.

- **Absolute Encoder Multi-Turn**: In addition to knowing the shaft position, multi-turn absolute encoders can also determine how many turns an encoder has made in one direction or the other.

### Encoder Technology
- **Conductive**: These encoders use a series of conductive pads. Incremental encoders’ pads transmit pulses in the case of incremental encoders, while absolute encoders’ pads position data.

- **Optical**: For optical sensing, encoders feature a light that is incrementally interrupted by a disk or other means attached to the shaft. This light transmits pulses for incremental encoders and transmits position data for absolute encoders.

- **Magnetic**: A magnet or series of magnets transmit rotational information.

- **Capacitive**: This newer technology senses the repeatable pattern of capacitance in a rotor setup.

### Hall Sensors - 

![FOC](/Images/Hall_sensor_tach.gif)
