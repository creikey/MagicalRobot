#!/usr/bin/env python
import magicbot
import wpilib
import logging
import coloredlogs


class Robot(magicbot.MagicRobot):

    def createObjects(self):
        """Creates component objects assosciated with hardware, run on robot init"""
        # initialize colored logging
        field_styles = coloredlogs.DEFAULT_FIELD_STYLES
        field_styles['filename'] = {'color': 'cyan'}
        coloredlogs.install(level='DEBUG',
                            fmt="%(asctime)s[%(msecs)d] %(filename)s:%(lineno)d %(name)s %(levelname)s %(message)s", datefmt="%m-%d %H:%M:%S", field_styles=field_styles)  # install to created handler

    def teleopInit(self):
        """Called on first launch of teleop mode"""
        pass

    def teleopPeriodic(self):
        """Called on every packet received by the robot, about 60 times per second"""
        pass


# run magicbot when executed as a script
if __name__ == '__main__':
    wpilib.run(Robot)
