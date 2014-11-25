// vim : set fileencoding=utf-8 expandtab noai ts=4 sw=4 :
/// @addtogroup pysc
/// @{
/// @file amba.i
/// 
/// @date 2013-2014
/// @copyright All rights reserved.
///            Any reproduction, use, distribution or disclosure of this
///            program, without the express, prior written consent of the 
///            authors is strictly prohibited.
/// @author Rolf Meyer
%module _amba

%include "std_string.i"
%include "stdint.i"
%include "usi.i"

%{
USI_REGISTER_MODULE(_amba)
%}
%{
#include "core/common/amba.h"
#include "core/models/utils/ahbdevicebase.h"
#include "core/models/utils/apbdevicebase.h"
%}

%include "core/common/amba.h"
%include "core/models/utils/ahbdevicebase.h"
%include "core/models/utils/apbdevicebase.h"
PyObject *find_amba_device(std::string name);

%{
PyObject *find_amba_device(std::string name) {
  int count = 0;
  sc_core::sc_object *obj = sc_find_by_name(name.c_str());
  AHBDeviceBase *ahbdevice = dynamic_cast<AHBDeviceBase *>(obj);
  APBDeviceBase *apbdevice = dynamic_cast<APBDeviceBase *>(obj);
  count = bool(ahbdevice) + bool(apbdevice);
  PyObject *result = PyTuple_New(count);

  count = 0;
  if(ahbdevice) {
    PyObject *dev = SWIG_NewPointerObj(SWIG_as_voidptr(ahbdevice), SWIGTYPE_p_AHBDeviceBase, 0);
    PyTuple_SetItem(result, count++, dev);
  }
  if(apbdevice) {
    PyObject *dev = SWIG_NewPointerObj(SWIG_as_voidptr(apbdevice), SWIGTYPE_p_APBDeviceBase, 0);
    PyTuple_SetItem(result, count++, dev);
  }
  //Py_DECREF(result);
  return result;
}
%}

