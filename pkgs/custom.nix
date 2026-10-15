{ }:

finalPkgs: prevPkgs: {
  pcmanfm-qt = prevPkgs.pcmanfm-qt.overrideAttrs {
    patches = [
      ./by-name/pc/pcmanfm-qt/0001-qt-open-terminal-f12.patch
    ];

    qtWrapperArgs = [
      "--set GIO_EXTRA_MODULES ${finalPkgs.gvfs}/lib/gio/modules"
    ];
  };

  rofi-power-menu = prevPkgs.rofi-power-menu.overrideAttrs {
    patches = [
      ./by-name/ro/rofi-power-menu/0001-consistent-capitalization.patch
    ];
  };
}
