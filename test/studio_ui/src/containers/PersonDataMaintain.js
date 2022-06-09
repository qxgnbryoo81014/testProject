import React, { Fragment, useCallback, useEffect, useState } from 'react';
import { Controller, useForm } from 'react-hook-form';
import Breadscrumb from '../components/UI/Breadscrumb';
import Button from '../components/UI/Buttons/Button';
import ButtonOutline from '../components/UI/Buttons/ButtonOutline';
import ControlLabel from '../components/UI/ControlLabel';
import DatePicker from '../components/UI/DatePicker';
import ErrorHint from '../components/UI/ErrorHint';
import FormGroup from '../components/UI/FormGroup/FormGroup';
import SubGroup from '../components/UI/FormGroup/SubGroup';
import Select from '../components/UI/Select';
import Title from '../components/UI/Title';
import Well from '../components/UI/Well';
import { URL } from '../constants';
import { convertStringToRegex, formatDate, isValidCompanyID } from '../utils/utility';

const cities = require('../resource/selection/cities.json');
const districts = require('../resource/selection/districts.json');

const rulesOrigin = require('../resource/validation/account/registerAccount.json');
const rules = convertStringToRegex(rulesOrigin);

const pageList = [
    { name: '個人資料維護/修改作業' }
];

const PersonDataMaintain = props => {
    const { register, handleSubmit, control, errors, setValue, getValues } = useForm({ mode: "onBlur" });
    const [userAccount, setUserAccount] = useState(null);
    const [orgNames, setOrgNames] = useState({});

    const [districtList, setDistrictList] = useState(districts[cities[0].value]);

    const onSubmit = async data => {
        const user = JSON.parse(sessionStorage.getItem('user')).user;
        const finalData = {
            id: user.id,
            ...data,
        };

        const response = await fetch(`${URL}/user/updatePersonData`, {
            credentials: 'include',
            headers: { 'Content-Type': 'application/json' },
            method: 'PUT',
            body: JSON.stringify(finalData)
        });

        if (response.status === 200) {
            alert('個人資料維護儲存完成');
        } else alert('錯誤!');

        props.history.push('/');

    }

    const changePasswordHandler = () => {
        props.history.push('/PersonDataMaintain/ChangePassword');
    }

    const goBack = () => {
        window.history.back();
    }

    const getUserAccount = useCallback(async () => {
        const user = JSON.parse(sessionStorage.getItem('user')).user;
        const accountData = await fetch(`${URL}/user/getUserAccount/${user.account}`, {
            credentials: 'include',
            headers: { 'Content-Type': 'application/json' },
            method: 'GET'
        }).then(res => res.json());
        setValue("userDetail", accountData.userDetail);
        setUserAccount(accountData);
        setDistrictList(districts[accountData.userDetail.smOrg.addressCity]);
    }, [setValue]);

    // const initOrgNames = useCallback(async () => {
    //     const response = await fetch(`${URL}/user/getOrgNames`, {
    //         credentials: 'include',
    //         headers: { 'Content-Type': 'application/json' },
    //         method: 'GET'
    //     }).then(res => res.json());
        
    //     const names = await response.result;
    //     setOrgNames(names)
    // }, []);

    useEffect(() => {
        getUserAccount();
        // initOrgNames();
    // }, [getUserAccount, initOrgNames]);
}, [getUserAccount]);

    return (
        <Fragment>
            <Title>個人資料維護</Title>
            <Breadscrumb pages={pageList} />

            <form className='form-horizontal' onSubmit={handleSubmit(onSubmit)}>
                <Well>
                    <ControlLabel>個人基本資料</ControlLabel>

                    <FormGroup>
                        <SubGroup label='身份別:' showStar labelWidth='2' fieldWidth='4'>
                            <p>{userAccount && userAccount.role.groupName}</p>
                        </SubGroup>
                        <SubGroup label='身份識別碼:' showStar labelWidth='2' fieldWidth='4'>
                            <p>{userAccount && userAccount.userDetail.smOrg.orgId}</p>
                        </SubGroup>
                    </FormGroup>

                    <FormGroup>
                        <SubGroup label='帳號:' showStar labelWidth='2' fieldWidth='4'>
                            <p>{userAccount && userAccount.account}</p>
                        </SubGroup>
                        <SubGroup label='中文姓名:' showStar labelWidth='2' fieldWidth='4'>
                            <input
                                type='text'
                                className='form-control'
                                maxLength='16'
                                name='userDetail.name'
                                autoComplete='off'
                                ref={register(rules.userDetail.name)}
                            />
                            <ErrorHint errors={errors} name='userDetail.name' />
                        </SubGroup>
                    </FormGroup>

                    <FormGroup>
                        <SubGroup label='單位名稱:' showStar labelWidth='2' fieldWidth='4'>
                            <input
                                type='text'
                                className='form-control'
                                maxLength='128'
                                name='userDetail.smOrg.name'
                                autoComplete='off'
                                ref={register(rules.userDetail.smOrg.name)}
                                
                            />
                            <ErrorHint errors={errors} name='userDetail.smOrg.name' />
                        </SubGroup>
                        <SubGroup label='英文名稱:' labelWidth='2' fieldWidth='4'>
                            <input
                                type='text'
                                className='form-control'
                                name='userDetail.smOrg.engName'
                                maxLength='128'
                                autoComplete='off'
                                ref={register(rules.userDetail.engName)}
                            />
                            <ErrorHint errors={errors} name='userDetail.smOrg.engName' />
                        </SubGroup>
                    </FormGroup>

                    <FormGroup>
                        <SubGroup label='中文地址:' showStar labelWidth='2' fieldWidth='10'>
                            <div className='form-inline'>
                                <input
                                    type='text'
                                    className='form-control'
                                    name='userDetail.smOrg.addressZip'
                                    maxLength='128'
                                    autoComplete='off'
                                    ref={register(rules.userDetail.addressZip)}
                                    style={{ width: 'calc(33.333% - 5px)' }}
                                />
                                <Controller
                                    as={<Select options={cities} style={{ width: 'calc(33.333% - 5px)' }} />}
                                    control={control}
                                    name="userDetail.smOrg.addressCity"
                                    rules={rules.userDetail.addressCity}
                                    onChange={([e]) => {
                                        setDistrictList(districts[e.target.value]);
                                        setValue('userDetail.smOrg.addressDistrict', '');
                                        return e.target.value;
                                    }}
                                />
                                <Controller
                                    as={<Select options={districtList} style={{ width: 'calc(33.333% - 5px)' }} />}
                                    control={control}
                                    name="userDetail.smOrg.addressDistrict"
                                    rules={rules.userDetail.addressDistrict}
                                />
                                <input
                                    type='text'
                                    className='form-control'
                                    name='userDetail.smOrg.address'
                                    maxLength='128'
                                    autoComplete='off'
                                    ref={register(rules.userDetail.address)}
                                    style={{ width: '100%' }}
                                />
                            </div>
                            <ErrorHint errors={errors} name='userDetail.smOrg.addressZip' />
                            <ErrorHint errors={errors} name='userDetail.smOrg.addressCity' />
                            <ErrorHint errors={errors} name='userDetail.smOrg.addressDistrict' />
                            <ErrorHint errors={errors} name='userDetail.smOrg.address' />
                        </SubGroup>
                    </FormGroup>

                    <FormGroup>
                        <SubGroup label='英文地址:' labelWidth='2' fieldWidth='10'>
                            <input
                                type='text'
                                className='form-control'
                                name='userDetail.smOrg.engAddress'
                                maxLength='128'
                                autoComplete='off'
                                ref={register(rules.userDetail.engAddress)}
                            />
                            <ErrorHint errors={errors} name='userDetail.smOrg.engAddress' />
                        </SubGroup>
                    </FormGroup>

                    <FormGroup>
                        <SubGroup label='聯絡人姓名:' showStar labelWidth='2' fieldWidth='4'>
                            <input
                                type='text'
                                className='form-control'
                                name='userDetail.smOrg.contactName'
                                maxLength='128'
                                autoComplete='off'
                                ref={register(rules.userDetail.contactName)}
                            />
                            <ErrorHint errors={errors} name='userDetail.smOrg.contactName' />
                        </SubGroup>
                        <SubGroup label='聯絡電話:' showStar labelWidth='2' fieldWidth='4'>
                            <input
                                type='text'
                                className='form-control'
                                name='userDetail.smOrg.phone'
                                maxLength='128'
                                autoComplete='off'
                                ref={register(rules.userDetail.phone)}
                            />
                            <ErrorHint errors={errors} name='userDetail.smOrg.phone' />
                        </SubGroup>
                    </FormGroup>

                    <FormGroup>
                        <SubGroup label='傳真電話:' labelWidth='2' fieldWidth='4'>
                            <input
                                type='text'
                                className='form-control'
                                name='userDetail.smOrg.fax'
                                maxLength='128'
                                autoComplete='off'
                                ref={register(rules.userDetail.fax)}
                            />
                            <ErrorHint errors={errors} name='userDetail.smOrg.fax' />
                        </SubGroup>
                        <SubGroup label='行動電話:' labelWidth='2' fieldWidth='4'>
                            <input
                                type='text'
                                className='form-control'
                                name='userDetail.mobile'
                                maxLength='32'
                                autoComplete='off'
                                ref={register(rules.userDetail.mobile)}
                            />
                            <ErrorHint errors={errors} name='userDetail.mobile' />
                        </SubGroup>
                    </FormGroup>

                    <FormGroup>
                        <SubGroup label='電子信箱:' showStar labelWidth='2' fieldWidth='4'>
                            <input
                                type='text'
                                className='form-control'
                                name='userDetail.email'
                                maxLength='64'
                                autoComplete='off'
                                ref={register(rules.userDetail.email)}
                            />
                            <ErrorHint errors={errors} name='userDetail.email' />
                        </SubGroup>
                        {/* <SubGroup label='是否為申辦代理人:' labelWidth='2' fieldWidth='4'>
                            <input
                                type='checkbox'
                                name='userDetail.agent'
                                ref={register(rules.userDetail.agent)}
                                style={{ width: '16px', height: '16px' }}
                            />
                        </SubGroup> */}
                    </FormGroup>
                    {
                        userAccount &&
                        userAccount.role.groupNo === 'SYUR' &&
                        isValidCompanyID(userAccount.userDetail.smOrg.orgId) &&
                        <Fragment>
                            <ControlLabel>公司登記證資料</ControlLabel>

                            <FormGroup>
                                <SubGroup label='負責人:' labelWidth='2' fieldWidth='4'>
                                    <input
                                        type='text'
                                        className='form-control'
                                        maxLength='128'
                                        name='userDetail.smOrg.companyOwner'
                                        defaultValue={userAccount.userDetail.smOrg.companyOwner}
                                        ref={register(rules.userDetail.companyOwner)}
                                        autoComplete='off'
                                    />
                                    <ErrorHint errors={errors} name='userDetail.smOrg.companyOwner' />
                                </SubGroup>
                                <SubGroup label='公司設立日期:' labelWidth='2' fieldWidth='4' >
                                    <Controller
                                        as={<DatePicker />}
                                        control={control}
                                        valueName='selected'
                                        defaultValue={formatDate(userAccount.userDetail.smOrg.companyDate)}
                                        name='userDetail.smOrg.companyDate'
                                    />
                                </SubGroup>
                            </FormGroup>

                            <FormGroup>
                                <SubGroup label='登記縣市:' showStar labelWidth='2' fieldWidth='4'>
                                    <Controller
                                        as={<Select options={cities} />}
                                        control={control}
                                        name="userDetail.smOrg.companyAddressCity"
                                        defaultValue={userAccount.userDetail.smOrg.companyAddressCity}
                                        rules={rules.userDetail.companyAddressCity}
                                    />
                                    <ErrorHint errors={errors} name='userDetail.smOrg.companyAddressCity' />
                                </SubGroup>
                            </FormGroup>

                            <FormGroup>
                                <SubGroup label='營業項目:' labelWidth='2' fieldWidth='10'>
                                    <textarea
                                        maxLength="1024"
                                        className='form-control'
                                        name='userDetail.smOrg.companyBusiness'
                                        defaultValue={userAccount.userDetail.smOrg.companyBusiness}
                                        ref={register(rules.userDetail.companyBusiness)}
                                        rows='3'
                                    />
                                    <ErrorHint errors={errors} name='userDetail.smOrg.companyBusiness' />
                                </SubGroup>
                            </FormGroup>

                        </Fragment>
                    }

                    {
                        userAccount &&
                        userAccount.role.groupNo === 'SYCA' &&
                        <Fragment>
                            <ControlLabel>機關資料</ControlLabel>

                            <FormGroup>
                                <SubGroup label='所屬縣市:' showStar labelWidth='2' fieldWidth='4'>
                                    <Controller
                                        as={<Select options={cities} />}
                                        control={control}
                                        defaultValue={userAccount.userDetail.smOrg.companyAddressCity}
                                        name='userDetail.smOrg.companyAddressCity'
                                        rules={rules.userDetail.companyAddressCity}
                                    />
                                    <ErrorHint errors={errors} name='userDetail.smOrg.companyAddressCity' />
                                </SubGroup>
                                <SubGroup label='單位組室:' labelWidth='2' fieldWidth='4'>
                                    <input
                                        type='text'
                                        className='form-control'
                                        maxLength='128'
                                        autoComplete='off'
                                        name='userDetail.smOrg.companyUnit'
                                        defaultValue={userAccount.userDetail.smOrg.companyUnit}
                                        ref={register(rules.userDetail.companyUnit)}
                                    />
                                    <ErrorHint errors={errors} name='userDetail.smOrg.companyUnit' />
                                </SubGroup>
                            </FormGroup>
                        </Fragment>
                    }

                    {
                        userAccount &&
                        userAccount.role.groupNo === 'SYMG' &&
                        <Fragment>
                            <ControlLabel>機關資料</ControlLabel>

                            <FormGroup>
                                <SubGroup label='所屬機關:' showStar labelWidth='2' fieldWidth='4'>
                                    <Controller
                                        as={<Select options={orgNames['SYMG']} />}
                                        control={control}
                                        defaultValue={userAccount.userDetail.smOrg.orgId}
                                        name='userDetail.smOrg.orgId'
                                        rules={{ required: '所屬機關不可空白' }}
                                    />
                                    <ErrorHint errors={errors} name='userDetail.smOrg.orgId' />
                                </SubGroup>
                            </FormGroup>
                        </Fragment>
                    }

                    <FormGroup>
                        <SubGroup fieldWidth='12'>
                            <div className='btn-box'>
                                <Button>儲存</Button>
                                <Button type='button' onClick={changePasswordHandler}>修改密碼</Button>
                                <ButtonOutline type='button' onClick={goBack}>返回</ButtonOutline>
                            </div>
                        </SubGroup>
                    </FormGroup>
                </Well>
            </form>
        </Fragment>
    );
}

export default PersonDataMaintain;