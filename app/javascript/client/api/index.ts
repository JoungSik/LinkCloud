import axios, { AxiosResponse } from 'axios';
import { UserType } from '../models/user';

const baseUrl = "http://link.joungsik.com/v1/";

const instance = axios.create({
    baseURL: baseUrl,
    timeout: 15000,
    headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Access-Control-Expose-Headers': 'Access-Token, Uid'
    }
});

const authInstance = (jwt: string) => axios.create({
    baseURL: baseUrl,
    timeout: 15000,
    headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': jwt
    }
});

const responseBody = (response: AxiosResponse<{}>) => response.data;

export const requests = {
    get: (url: string, jwt: string) => authInstance(jwt).get(url).then(responseBody),
    post: (url: string, body: {}, jwt: string) => authInstance(jwt).post(url, body).then(responseBody),
    patch: (url: string, body: {}, jwt: string) => authInstance(jwt).put(url, body).then(responseBody),
    delete: (url: string, jwt: string) => authInstance(jwt).delete(url).then(responseBody),
};

export const User = {
    register: (user: UserType) => instance.post('users', user),
    login: (user: UserType) => instance.post('login', user),
    logout: () => instance.delete('logout'),
}