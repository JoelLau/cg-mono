import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { retry } from 'rxjs';
import { environment } from 'src/environments/environment';

@Injectable({
  providedIn: 'root',
})
export class ShortUrlApiService {
  readonly BASE_URL = environment.api_base_path;

  constructor(private http: HttpClient) {}

  createShortUrl(targetUrl: string) {
    const params: CreateShortUrlRequest = {
      target_url: targetUrl,
    };

    return this.http
      .post<CreateShortUrlResponse>(`${this.BASE_URL}/short_urls`, params)
      .pipe(retry(1));
  }
}

export interface CreateShortUrlRequest {
  target_url: string;
}

export type CreateShortUrlResponse =
  | CreateShortUrlResponseSuccess
  | CreateShortUrlResponseError;
export type CreateShortUrlResponseSuccess = unknown;
export type CreateShortUrlResponseError = unknown;
