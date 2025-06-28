---
title: OSC-JavaScript
date:
---
Institute for Computer Music and Sound Technology / (ICST) Zurich University of the Arts

----
### Custom OSC - JS Help:

![JavaScript](Evernote/OSC-JavaScript/JavaScript.jpg)

Title (optional):");
  If the first line starts with a comment (//), this comment
  is used as title and will be shown in the Custom OSC list.

Access to OSC data:
  s.path([index]);
    Returns the specified part of the OSC path.
    Example: /this/is/my/path -> s.path(3); -> 'my'
  s.arg([index]);
    Returns the specified argument of the OSC message.
    Example: /demo 1 2 3 -> s.arg(2); -> 2

Access to current data:
  s.getX([index]); (*)
  s.getY([index]); (*)
  s.getZ([index]); (*)
  s.getA([index]); (*)
  s.getE([index]); (*)
  s.getD([index]); (*)
  s.getName([index]);
  s.getAbsX([index]); (group mode only)
  s.getAbsY([index]); (group mode only)
  s.getAbsZ([index]); (group mode only)
  s.getGroupX([index]);
  s.getGroupY([index]);
  s.getGroupZ([index]);
  s.getGroupA([index]);
  s.getGroupE([index]);
  s.getGroupD([index]);
(*) Note: in group mode, positions are relative to the attached group!

Manipulation of data set:
  s.setXYZ([index], [x], [y], [z]);
    Sets XYZ coordinates of the specified source index.
    Example: s.setXYZ(1, 1.0, 0.5, 0.1);
  s.setXYZbyName([name], [x], [y], [z]);
    Sets XYZ coordinates of the source with the specified name.
    Example: s.setXYZbyName(\"flute\", 0.5, 0.5, 0);
  s.setAED([index], [x], [y], [z]);
  s.setAEDbyName([name], [x], [y], [z]);
    Same for AED coordinates.

Group manipulations:
  s.setGroupXYZ([index], [x], [y], [z], [optional: moveSub]);
    Sets XYZ coordinates of the specified group index.
    Example: s.setGroupXYZ(1, 1.0, 0.5, 0.1, 1);
  s.setXYZbyName([name], [x], [y], [z], [optional: moveSub]);
    Sets XYZ coordinates of the source with the specified name.
    Example: s.setXYZbyName(\"woodwinds\", 0.5, 0.5, 0, 0);
  s.setGroupAED([index], [x], [y], [z], [optional: moveSub]);
  s.setGroupAEDbyName([name], [x], [y], [z], [optional: moveSub]);
    Same for AED coordinates.
  s.rotateGroup([index], [x], [y], [z]);
    Rotates the attached sources around the group point.
    x, y, z define the relative axis-rotation in degrees.
    Example: s.rotateGroup(1, 0.0, 0.0, 10.0);
  s.rotateAroundOrigin([index], [x], [y], [z], [optional: moveSub]);
    Rotates the group point around the origin (0,0,0).
    x, y, z define the relative axis-rotation in degrees.
    Example: s.rotateGroupAroundOrigin(1, 0.0, 0.0, 10.0);
  s.rotateGroupByName([name], [x], [y], [z]);
  s.rotateAroundOriginByName([name], [x], [y], [z], [optional: moveSub]);
    Same with identification of the group by name.

  The optional parameter moveSub defines:
    0: group point only
    1: group point and attached sources, preserving relative positions.
    (default is 1)

Additional methods for group mode (absolute rotation and stretch):
  s.setGroupRotation([index], [x], [y], [z], [w]);
    Sets the absolute rotation of the group to the specified quaternion.
  s.setGroupRotationEuler([index], [x], [y], [z]);
    Sets the absolute rotation of the group to the specified axis rotations.
  s.setGroupStretch([index], [stretchFactor]);
    Sets the absolute stretch factor.
  s.setGroupRotationByName([name], [x], [y], [z], [w]);
  s.setGroupRotationEulerByName([name], [x], [y], [z], [w]);
  s.setGroupStretchByName([name], [stretchFactor]);
    Same with identification of the group by name.

Local buffer:
  The local buffer allows to store values between OSC messages.
  Up to 1000 float values can be stored and recalled anytime.
  s.setBufferValue([index], [value]);
    Saves the specified value at buffer position [index].
    Example: s.setBufferValue(1, 25.0);
  s.getBufferValue([index]);
    Gets the value stored at buffer position [index].
    Example: s.getBufferValue(1);

Error handling:
  Java Script syntax errors will be displayed at interpretation time.
  Errors in the methods defined above, will be automatically displayed,
  however, it's possible to handle these errors in the Java Script code:
    All getter-methods return the value if available, 'undefined' otherwise.
    All setter-methods return true if successful, 'undefined' otherwise.
    s.reportError([message]);
      Allows custom error reporting.
      Example: if(s.setXYZ(i, x, y, z) != true) s.reportError("beep");
    s.reportError("");
      Resets the automatically generated error message to ignore the error.

Note: all 'index' parameters are 1-based, except for the 'Local Buffer' methods

---
©2025 ICST
