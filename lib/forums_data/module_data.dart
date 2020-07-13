class ModuleCodes {
  final String moduleCode;
  ModuleCodes({
    this.moduleCode,
  });
}

List<ModuleCodes> loadModuleCodes() {
  var mc = <ModuleCodes>[
    ModuleCodes(
      moduleCode: "ST2334"
    ),
    ModuleCodes(
      moduleCode: "CS1231"
    ),
    ModuleCodes(
      moduleCode: "CS1101S"
    ),
    ModuleCodes(
      moduleCode: "IS1103"
    ),
    ModuleCodes(
      moduleCode: "MA1521"
    ),
    ModuleCodes(
      moduleCode: "MA1101R"
    ),
    ModuleCodes(
      moduleCode: "BT1101"
    ),
    ModuleCodes(
      moduleCode: "CS2040S"
    ),
    ModuleCodes(
      moduleCode: "CS2100"
    ),
    ModuleCodes(
      moduleCode: "CS2103T"
    ),
    ModuleCodes(
      moduleCode: "CS2030"
    ),
    ModuleCodes(
      moduleCode: "ES2660"
    ),
  ];
  return mc;
}