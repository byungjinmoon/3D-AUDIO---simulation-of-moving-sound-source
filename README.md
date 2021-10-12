# 3D AUDIO - simulation of moving sound source

An implementation of moving sound source in Matlab.

Moving sound source implementation of:

* [Real-time Spatial Representation of Moving Sound Sources][research]

[research]: https://www.researchgate.net/publication/267553744_Real-time_Spatial_Representation_of_Moving_Sound_Sources


# Background

The simulation of moving sound sources represents a important issue for efficiently representing virtual worlds  and acoustic environments. But it is limited by the Head Related Transfer Function (HRTF) resolution measurement, usually overcome by interpolation techniques.
In this [research][research], the proposed algorithm overcomes discontinuity of sound and the excessive calculation load problems usually raised by moving sound source spatial representation techniques, while high-quality 3D sound spatial quality is achieved.

![image](https://user-images.githubusercontent.com/86009768/136959961-12dcd7fd-b5bd-4484-9813-c43353a8d45a.png)

### Solutions

1. Fade In/Out  window

2. FFT-based Overlap-Add block convolution

# Implementation 1 - windowing fade in, fade out

Artifact occurs when head related impulse response (HRIR) switches, but it becomes smooth when fade in and out is applied.
![image](https://user-images.githubusercontent.com/86009768/136981140-c4c31b0d-033a-40a7-9d2d-5af3d74dd5db.png)

* Windowing fade in, fade out
  We can use the Fourier window to apply fade in and fade out in overlap-add. 
  
  ![image](https://user-images.githubusercontent.com/86009768/136982838-8030f0b4-a3d4-44f9-a6fc-7c0cc27c357c.png)

# Implementation 2 -  fast convolution HRIR switching
  1. Not windowing fade in/out
     * example) Input : Sine wave
     ![image](https://user-images.githubusercontent.com/86009768/136984586-0fd81246-9230-4064-9013-d9a14dfbdde2.png)
     * Result (output y)
       ![image](https://user-images.githubusercontent.com/86009768/136984766-47a129b0-154d-497f-a2a0-85f57d612592.png)

  3. 

