codeunit 58107 "WherMediaSetUsdFrstMeth WLD"
{
    internal procedure GetWhereUsedFirst(var TenantMediaSet: Record "Tenant Media Set") Result: Text
    var
        IsHandled: Boolean;
    begin
        OnBeforeGetWhereUsedFirst(TenantMediaSet, Result, IsHandled);

        DoGetWhereUsedFirst(TenantMediaSet, Result, IsHandled);

        OnAfterGetWhereUsedFirst(TenantMediaSet, Result);
    end;

    local procedure DoGetWhereUsedFirst(var TenantMediaSet: Record "Tenant Media Set"; var Result: Text; IsHandled: Boolean);
    var
        Fld: Record Field;
    begin
        if IsHandled then
            exit;

        fld.SetRange(ObsoleteState, fld.ObsoleteState::No);
        fld.SetRange(Type, fld.Type::MediaSet);
        if not fld.FindSet() then exit;

        repeat
            if ContainsReference(TenantMediaSet.ID, fld.TableNo, fld."No.", TenantMediaSet."Company Name") then begin
                Result := fld.TableName + '(' + format(fld.TableNo) + ')';
                exit;
            end
        until fld.Next() < 1;
    end;

    local procedure ContainsReference(TenantMediaSetId: Guid; TableNo: Integer; FieldNo: Integer; CompanyName: Text[30]): Boolean
    var
        FldRef: FieldRef;
        RecRef: RecordRef;
    begin
        RecRef.Open(TableNo);
        RecRef.ChangeCompany(CompanyName);
        FldRef := RecRef.Field(FieldNo);
        FldRef.SetRange(TenantMediaSetId);

        exit(not RecRef.IsEmpty);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeGetWhereUsedFirst(var TenantMediaSet: Record "Tenant Media Set"; var Result: Text; var IsHandled: Boolean);
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterGetWhereUsedFirst(var TenantMediaSet: Record "Tenant Media Set"; var Result: Text);
    begin
    end;
}