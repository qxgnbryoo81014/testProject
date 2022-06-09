import React, { useCallback, useState, useEffect } from 'react';
import Well from '../components/UI/Well';
import FormGroup from '../components/UI/FormGroup/FormGroup';
import SubGroup from '../components/UI/FormGroup/SubGroup';
import { useForm } from 'react-hook-form';
import Button from '../components/UI/Buttons/Button';
import ErrorHint from '../components/UI/ErrorHint';
import { convertStringToRegex } from '../utils/utility';
import ButtonOutline from '../components/UI/Buttons/ButtonOutline';
import { URL } from '../constants';
import Title from '../components/UI/Title';
import Breadscrumb from '../components/UI/Breadscrumb';

import { arrayBufferToBase64 } from '../utils/utility';

const pageList = [
    { name: '個人資料維護/變更密碼' }
];

const rulesOrigin = require('../resource/validation/account/registerOrgAccount.json');
const rules = convertStringToRegex(rulesOrigin);

const ChangePassword = (props) => {
    const { register, errors, getValues, handleSubmit, reset } = useForm();
    const [captchaImage, setCaptchaImage] = useState(null);

    const fetchCaptcha = useCallback(async () => {
        const response = await fetch(`${URL}/auth/captcha`, {
            credentials: 'include'
        });

        const img = await response.arrayBuffer().then((buffer) => {
            var base64Flag = 'data:image/jpeg;base64,';
            var imageStr = arrayBufferToBase64(buffer);
            return base64Flag + imageStr;
        });
        setCaptchaImage(img)
    }, []);


    const onSubmit = async (data) => {
        const {user} = JSON.parse(sessionStorage.getItem('user'));
        const response = await fetch(`${URL}/auth/changePassword`, {
            credentials: 'include',
            headers: { 'Content-Type': 'application/json' },
            method: 'PUT',
            body: JSON.stringify({
                account: user.account,
                oldPassword: data.oldPassword,
                password: data.passowrd,
                answer: data.answer
            })
        });

        if (response.status === 200) {
            alert('密碼變更完成!');
            props.history.push('/');
        } else if (response.status === 401) {
            alert('舊密碼錯誤!');
            resetHandler();
            fetchCaptcha();
        } else if (response.status === 403) {
            alert('驗證碼錯誤!');
            resetHandler();
            fetchCaptcha();
        } else {
            alert('錯誤! Error Code:' + response.status);
            goBack();
        }
    }

    const resetHandler = () => {
        const defaultLoginData = { oldPassword: '', passowrd: '', answer: '' };
        reset(defaultLoginData);
    }

    const goBack = () => {
        window.history.back();
    }

    useEffect(() => {
        fetchCaptcha();
    }, [fetchCaptcha]);

    return (
        <div>
            <Title>個人資料維護</Title>
            <Breadscrumb pages={pageList} />
            <form className="form-horizontal" onSubmit={handleSubmit(onSubmit)}>
                <Well>
                    <FormGroup>
                        <SubGroup label='舊密碼:' labelWidth='4' fieldWidth='4'>
                            <input
                                type="password"
                                className="form-control"
                                name="oldPassword"
                                ref={register}
                                autoComplete="off"
                            />
                        </SubGroup>
                    </FormGroup>

                    <FormGroup>
                        <SubGroup label='新密碼:' labelWidth='4' fieldWidth='4'>
                            <input
                                type="password"
                                className="form-control"
                                name="passowrd"
                                ref={register({
                                    ...rules.pwd,
                                    validate: value => getValues()['oldPassword'] === value ? '新密碼不可與舊密碼相同' : undefined
                                })}
                                autoComplete="off"
                            />
                            <ErrorHint errors={errors} name='passowrd' />
                        </SubGroup>
                    </FormGroup>

                    <FormGroup>
                        <SubGroup label='確認新密碼:' labelWidth='4' fieldWidth='4'>
                            <input
                                type="password"
                                className="form-control"
                                name="pwdSecond"
                                ref={register({
                                    validate: value => {
                                        return getValues()['passowrd'] !== value ? '密碼輸入不相符' : undefined;
                                    }
                                })}
                                autoComplete="off"
                            />
                            <ErrorHint errors={errors} name='pwdSecond' />
                        </SubGroup>
                    </FormGroup>

                    <FormGroup>
                        <SubGroup label='驗證碼:' labelWidth='4' fieldWidth='2'>
                            <input
                                type='text'
                                className="form-control"
                                name="answer"
                                ref={register}
                                autoComplete="off"
                            />
                        </SubGroup>
                        <SubGroup fieldWidth='4'>
                            <div style={{ textAlign: 'left' }}>
                                {captchaImage && <img src={captchaImage} alt='驗證碼' style={{ marginRight: '10px', border: '1px solid #cccccc' }} />}
                                <button
                                    type='button'
                                    className='rnBt_icon'
                                    onClick={fetchCaptcha}
                                >
                                    <img src='../images/rn.png' alt='重置驗證碼' />
                                </button>
                            </div>
                        </SubGroup>
                    </FormGroup>

                    <div className='btn-box'>
                        <Button>儲存</Button>
                        <ButtonOutline type='button' onClick={goBack}>返回</ButtonOutline>
                    </div>
                </Well>
            </form>
        </div>
    );
}

export default ChangePassword;