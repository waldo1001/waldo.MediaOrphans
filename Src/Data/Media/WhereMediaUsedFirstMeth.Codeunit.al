codeunit 58104 "WhereMediaUsedFirstMeth WLD"
{
    internal procedure GetWhereUsedFirst(var TenantMedia: Record "Tenant Media") Result: Text
    var
        IsHandled: Boolean;
    begin
        OnBeforeGetWhereUsedFirst(TenantMedia, Result, IsHandled);

        DoGetWhereUsedFirst(TenantMedia, Result, IsHandled);

        OnAfterGetWhereUsedFirst(TenantMedia, Result);
    end;

    local procedure DoGetWhereUsedFirst(var TenantMedia: Record "Tenant Media"; var Result: Text; IsHandled: Boolean);
    var
        Fld: Record Field;
    begin
        if IsHandled then
            exit;

        fld.SetRange(ObsoleteState, fld.ObsoleteState::No);
        fld.SetRange(Type, fld.Type::Media);
        if not fld.FindSet() then exit;

        repeat
            if ContainsReference(TenantMedia.ID, fld.TableNo, fld."No.", TenantMedia."Company Name") then begin
                Result := fld.TableName + '(' + format(fld.TableNo) + ')';
                exit;
            end
        until fld.Next() < 1;
    end;

    local procedure ContainsReference(TenantMediaId: Guid; TableNo: Integer; FieldNo: Integer; CompanyName: Text[30]): Boolean
    var
        FldRef: FieldRef;
        RecRef: RecordRef;
    begin
        RecRef.Open(TableNo);
        RecRef.ChangeCompany(CompanyName);
        FldRef := RecRef.Field(FieldNo);
        FldRef.SetRange(TenantMediaId);

        exit(not RecRef.IsEmpty);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeGetWhereUsedFirst(var TenantMedia: Record "Tenant Media"; var Result: Text; var IsHandled: Boolean);
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterGetWhereUsedFirst(var TenantMedia: Record "Tenant Media"; var Result: Text);
    begin
    end;
}