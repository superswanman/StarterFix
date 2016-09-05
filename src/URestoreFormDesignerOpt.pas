unit URestoreFormDesignerOpt;

interface

uses
  Winapi.Windows, System.Rtti;

procedure Register;

implementation

const
  VclIde = {$IFDEF VER290}'vclide220.bpl'{$ENDIF}
           {$IFDEF VER300}'vclide230.bpl'{$ENDIF}
           {$IFDEF VER310}'vclide240.bpl'{$ENDIF}
           ;
  RegisterProcName = '@Idepropsheet@RegisterPropertySheetClass$qqrp17System@TMetaClass';
  UnregisterProcName = '@Idepropsheet@UnregisterPropertySheetClass$qqrp17System@TMetaClass';
  TargetQualifiedClassName = 'DesignerOptPage.TDesignerOptionsPage';

var
  TDesignerOptionsPageClass: TClass;

procedure Register;
var
  ctx: TRttiContext;
  typ: TRttiType;
  proc: procedure(AClass: TClass);
begin
  typ := ctx.FindType(TargetQualifiedClassName);
  if typ = nil then Exit;
  TDesignerOptionsPageClass := TRttiInstanceType(typ).MetaclassType;

  @proc := GetProcAddress(GetModuleHandle(VclIde), RegisterProcName);
  if @proc = nil then Exit;

  proc(TDesignerOptionsPageClass);
end;

procedure Unregister;
var
  proc: procedure(AClass: TClass);
begin
  if TDesignerOptionsPageClass = nil then Exit;

  @proc := GetProcAddress(GetModuleHandle(VclIde), UnregisterProcName);
  if @proc = nil then Exit;
  proc(TDesignerOptionsPageClass);
end;

initialization
finalization
  Unregister;
end.