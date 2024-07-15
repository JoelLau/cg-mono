import { TestBed } from '@angular/core/testing';
import { ShortUrlApiService } from './short-url-api.service';

describe(ShortUrlApiService.name, () => {
  let service: ShortUrlApiService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(ShortUrlApiService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
