codeunit 58105 "WhereMediaUsed Meth WLD"
{
    internal procedure GetWhereUsed(var TenantMedia: Record "Tenant Media") Result: Text
    var
        IsHandled: Boolean;
    begin
        OnBeforeGetWhereUsed(TenantMedia, Result, IsHandled);

        DoGetWhereUsed(TenantMedia, Result, IsHandled);

        OnAfterGetWhereUsed(TenantMedia, Result);
    end;

    local procedure DoGetWhereUsed(var TenantMedia: Record "Tenant Media"; var Result: Text; IsHandled: Boolean);
    var
        Company: Record Company;
        Fld: Record Field;
    begin
        if IsHandled then
            exit;

        fld.SetRange(ObsoleteState, fld.ObsoleteState::No);
        fld.SetRange(Type, fld.Type::Media);
        if not fld.FindSet() then exit;

        repeat

            if not Company.FindSet() then exit;
            repeat
                if ContainsReference(TenantMedia.ID, fld.TableNo, fld."No.", Company.Name) then
                    if Result = '' then
                        Result := fld.TableName + '(' + format(fld.TableNo) + ') - (' + Company.Name + ')'
                    else
                        Result += '\' + fld.TableName + '(' + format(fld.TableNo) + ') - (' + Company.Name + ')';

            until Company.Next() < 1;

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
    local procedure OnBeforeGetWhereUsed(var TenantMedia: Record "Tenant Media"; var Result: Text; var IsHandled: Boolean);
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterGetWhereUsed(var TenantMedia: Record "Tenant Media"; var Result: Text);
    begin
    end;
}